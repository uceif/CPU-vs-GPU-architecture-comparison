# Member 3 — Cache & Memory Optimizer
## Cache-Aware Matrix Multiplication: Measuring the Cost of Memory Access Patterns

**Project:** CPU vs GPU Architecture Comparison  
**Role:** Member 3 — Cache & Memory Optimizer  
**Algorithm:** 1024×1024 matrix multiplication (same as Member 1 baseline)  
**Focus:** How loop order and cache blocking affect real performance — without changing the math.

---

## Table of Contents

1. [What This Part Is About](#1-what-this-part-is-about)
2. [Background: The CPU Cache Hierarchy](#2-background-the-cpu-cache-hierarchy)
3. [Why Matrix Layout Matters](#3-why-matrix-layout-matters)
4. [The Four Versions Tested](#4-the-four-versions-tested)
5. [Real Benchmark Results](#5-real-benchmark-results)
6. [Analysis: Why Each Version Is Fast or Slow](#6-analysis-why-each-version-is-fast-or-slow)
7. [Cache Blocking (Tiling) — Deep Dive](#7-cache-blocking-tiling--deep-dive)
8. [Valgrind Cachegrind Instructions](#8-valgrind-cachegrind-instructions)
9. [Connection to Other Members](#9-connection-to-other-members)
10. [Report-Ready Sections](#10-report-ready-sections)
11. [Oral Defense Q&A](#11-oral-defense-qa)

---

## 1. What This Part Is About

Member 1 showed what the compiler does to the *same* code at different optimization levels.  
Member 2 showed what happens when you give the work to multiple CPU cores or the GPU.

**My part asks a different question:** given *identical arithmetic*, how much does the *order of memory accesses* matter?

The answer, from our real measurements:

| Version | Time  | Speedup |
|---------|-------|---------|
| `ijk` (textbook, Member 1 baseline) | 3.31 s | 1.00× |
| `ikj` (loop reorder — cache-friendly) | 0.69 s | **4.78×** |
| `jki` (worst possible order) | 17.64 s | 0.19× |
| Tiled / Cache-blocked | 0.74 s | **4.49×** |

**The same 2 billion arithmetic operations. The same compiler flags (`-O2`). Speedups up to 4.78× just from changing which memory addresses are accessed in which order.**

This is the core lesson of the cache hierarchy.

---

## 2. Background: The CPU Cache Hierarchy

Modern CPUs cannot feed data to their arithmetic units directly from RAM — RAM is far too slow (~100 ns latency, ~200+ clock cycles). Instead, they have a hierarchy of small, fast caches:

```
 Registers       ~0 cycles    (data already in the CPU)
    │
   L1 cache      ~4 cycles    32–48 KB per core    64-byte lines
    │
   L2 cache      ~12 cycles   256 KB – 1 MB/core
    │
   L3 cache      ~40 cycles   4–32 MB shared
    │
   DRAM          ~200 cycles  8–32 GB
```

**Cache line:** The unit of transfer between any two levels is always 64 bytes (8 doubles). When you request one double, the CPU fetches all 8 doubles surrounding it. If you use the neighbouring doubles next, those fetches are free. If you jump 8 KB away, you bring in a new cache line and the one you just fetched is eventually evicted without being reused — a **cache miss**.

**Our matrices:** Each 1024×1024 double matrix is 1024 × 1024 × 8 = **8 MB**. That is far larger than L1 (32–48 KB) and larger than L2 on most chips. Getting data to the arithmetic units is limited by how many cache misses we generate.

---

## 3. Why Matrix Layout Matters

Our matrices are stored in **row-major** order (standard C/C++):

```
A[0][0]  A[0][1]  A[0][2]  ...  A[0][1023]   ← row 0, contiguous in memory
A[1][0]  A[1][1]  ...                          ← row 1, 8 KB later
...
```

Element `A[i][j]` is at memory offset `(i*1024 + j) * 8` bytes from the start of the array.

Two kinds of access:

- **Row walk** (varying `j` with `i` fixed): addresses 0, 8, 16, 24, … — sequential, every cache line fully used → **no wasted fetches**
- **Column walk** (varying `i` with `j` fixed): addresses 0, 8192, 16384, … — stride of 8 KB, each cache line brings 8 doubles but only 1 is used → **87.5% of every cache line wasted**, line evicted before we come back

The textbook `ijk` loop does a column walk on `B`. That is the entire cause of its slowness relative to `ikj`.

---

## 4. The Four Versions Tested

All four compute the same `C = A × B` for 1024×1024 double matrices. All are compiled with `g++ -std=c++17 -O2`. The arithmetic is identical; only the order of loop indices changes.

### Version 1 — `ijk` (textbook, Member 1 baseline)

```cpp
for (int i = 0; i < N; ++i)
    for (int j = 0; j < N; ++j) {
        double sum = 0.0;
        for (int k = 0; k < N; ++k)
            sum += A[i*N+k] * B[k*N+j];   // B is column-strided!
        C[i*N+j] = sum;
    }
```

| Access | Pattern | Cache friendliness |
|--------|---------|-------------------|
| `A[i*N+k]` | k varies → row walk | ✅ sequential |
| `B[k*N+j]` | k varies, j fixed → **column walk** | ❌ stride 8 KB |
| `C[i*N+j]` | j varies → row walk | ✅ sequential |

### Version 2 — `ikj` (cache-optimized reorder)

```cpp
for (int i = 0; i < N; ++i)
    for (int k = 0; k < N; ++k) {
        double a_ik = A[i*N+k];    // hoisted: loaded once, stays in register
        for (int j = 0; j < N; ++j)
            C[i*N+j] += a_ik * B[k*N+j];   // B is now row-strided!
    }
```

| Access | Pattern | Cache friendliness |
|--------|---------|-------------------|
| `A[i*N+k]` | hoisted before j-loop | ✅ one load per k |
| `B[k*N+j]` | j varies, k fixed → **row walk** | ✅ sequential |
| `C[i*N+j]` | j varies → row walk (read-modify-write) | ✅ sequential |

**All three matrices are accessed sequentially.** This is why `ikj` is ~5× faster than `ijk` — not because we did different math, but because we did the same math in an order that uses cache lines efficiently.

### Version 3 — `jki` (intentional worst case)

```cpp
for (int j = 0; j < N; ++j)
    for (int k = 0; k < N; ++k) {
        double b_kj = B[k*N+j];    // hoisted
        for (int i = 0; i < N; ++i)
            C[i*N+j] += b_kj * A[i*N+k];   // both A and C are column-strided!
    }
```

| Access | Pattern | Cache friendliness |
|--------|---------|-------------------|
| `B[k*N+j]` | hoisted | ✅ one load per k |
| `A[i*N+k]` | i varies, k fixed → **column walk** | ❌ stride 8 KB |
| `C[i*N+j]` | i varies, j fixed → **column walk** | ❌ stride 8 KB |

Both `A` and `C` are column-strided. This is the worst of the six possible loop orders for row-major matrices.

### Version 4 — Tiled / Cache-Blocked

```cpp
for (int ii = 0; ii < N; ii += TILE)      // tile row of C/A
  for (int jj = 0; jj < N; jj += TILE)    // tile column of C/B
    for (int kk = 0; kk < N; kk += TILE)  // tile inner dimension
      // process one TILE×TILE block
      for (int i = ii; i < ii+TILE; ++i)
        for (int k = kk; k < kk+TILE; ++k) {
            double a_ik = A[i*N+k];
            for (int j = jj; j < jj+TILE; ++j)
                C[i*N+j] += a_ik * B[k*N+j];
        }
```

With `TILE = 64`, the working set per tile block is:
```
3 tiles × 64 × 64 elements × 8 bytes = 98 304 bytes ≈ 96 KB
```
This fits in L2 cache. The same tile data is reused for `TILE` iterations before moving on, instead of being evicted after one use.

---

## 5. Real Benchmark Results

Measured on the project machine, `g++ 13.3.0`, compiled with `-O2`:

```
=== Member 3: Cache & Memory Optimization ===
Matrix size : 1024 x 1024
Tile size   : 64 x 64
Working set per tile: 96 KB

----------------------------------------------------------
Version     Time(s)   GFLOPS    Checksum        Speedup vs ijk
----------------------------------------------------------
ijk         3.3141    0.6480    657440507200    1.00x
ikj         0.6935    3.0967    657440507200    4.78x
jki         17.6363   0.1218    657440507200    0.19x
tiled       0.7377    2.9112    657440507200    4.49x
----------------------------------------------------------

Correctness: all four checksums match ✓
```

### Key observations

1. **`ikj` is 4.78× faster than `ijk`** — just from reordering loops. No new algorithm, no parallelism, no SIMD changes.

2. **`jki` is 5.3× *slower* than `ijk`** — or 25× slower than `ikj`. It has two simultaneous column walks. This is the worst case and proves that cache patterns are a performance multiplier, not a minor tuning detail.

3. **Tiled is nearly as fast as `ikj`** (4.49× speedup). For this matrix size, `ikj` is already close to optimal because the compiler's sequential prefetcher handles it well. Tiling would show a larger advantage on matrices that are much bigger than L3 cache (e.g., 8192×8192).

4. **The checksum is identical in all four versions** — we are measuring pure cache effects, not correctness differences.

---

## 6. Analysis: Why Each Version Is Fast or Slow

### The L1 miss rate model

For the `ijk` inner loop (1024 iterations of `k`, with `j` fixed):
- `A[i*N+k]`: k increases → 128 cache lines, fully used → **1 miss per 8 accesses = 12.5% miss rate on A**
- `B[k*N+j]`: k increases → each access is 8 KB apart → **~100% miss rate on B (1 miss per access)**
- Total B load data: 1024 × 8 = 8 KB but spread across 1024 different cache lines

For the `ikj` inner loop (1024 iterations of `j`, with `k` fixed):
- `A[i*N+k]`: hoisted to register → **0 memory accesses in inner loop**
- `B[k*N+j]`: j increases → **1 miss per 8 accesses = 12.5% miss rate**
- `C[i*N+j]`: j increases → **1 miss per 8 accesses = 12.5% miss rate**
- Both B and C are read sequentially; hardware prefetcher can predict next address

The hardware prefetcher in modern CPUs can recognize sequential access patterns and pre-load the next cache line *before* the program asks for it — effectively hiding the latency. It cannot predict stride-8192 accesses because they skip entirely to different pages.

### Bandwidth calculation

At `-O2` with `ijk`, the inner loop stalls on nearly every `B[k*N+j]` load:
- 1024×1024×1024 B-accesses × 64 bytes/cache-line = 68 GB of cache-line fetches for B
- At typical L2→L3 bandwidth of ~200 GB/s, that's a minimum of 0.34 s *just for B accesses* — but L3 is also overwhelmed, so we see 3.3 s total

With `ikj`, B is accessed sequentially:
- Only 1024×1024×8 = 8 MB of *unique* B data is ever loaded
- It fits in L2/L3, and the prefetcher keeps it coming — we see 0.69 s total

---

## 7. Cache Blocking (Tiling) — Deep Dive

### Why tiling helps for very large matrices

For 1024×1024 matrices, `ikj` already works well because B (8 MB) fits in L3 cache on most modern CPUs. For a 4096×4096 matrix (128 MB per matrix), L3 is also overwhelmed and tiling becomes critical.

### How to choose TILE size

The tile must fit in the cache level you are targeting:

```
Working set = 3 × TILE² × sizeof(double)
            = 3 × TILE² × 8 bytes

For L1 (32 KB):  TILE ≤ sqrt(32768 / 24) ≈ 36  → TILE = 32
For L2 (256 KB): TILE ≤ sqrt(262144 / 24) ≈ 104 → TILE = 64 or 96
For L2 (1 MB):   TILE ≤ sqrt(1048576 / 24) ≈ 209 → TILE = 128 or 192
```

We used `TILE = 64` targeting L2. The rule of thumb: choose the largest TILE whose working set fits in the cache level just above where your data normally lives.

### Data reuse with tiling

Without tiling, a tile-row of `B` is loaded once per i-loop iteration and then evicted. With tiling:
- The same A-tile is reused for all `jj` tile columns → A loaded `N/TILE` times instead of `N` times
- The same B-tile is reused for all `ii` tile rows → B loaded `N/TILE` times instead of `N` times
- Reuse factor: `TILE` (= 64 in our case)

---

## 8. Valgrind Cachegrind Instructions

If you have Linux or WSL, you can measure cache misses directly:

```bash
# Compile with debug info for readable output
g++ -std=c++17 -O2 -g matmul_cache_opt.cpp -o matmul_cache_opt

# Run under cachegrind (this takes ~20× longer than normal execution)
valgrind --tool=cachegrind --cache-sim=yes --branch-sim=no ./matmul_cache_opt

# The output file is named cachegrind.out.<pid>
# Read it with:
cg_annotate cachegrind.out.<pid>
```

**What to look for in the output:**

```
I refs:        total instruction references
D refs:        total data references  (Dr = reads, Dw = writes)
D1 miss rate:  L1 data cache miss rate — this is what we're measuring
LLd miss rate: Last-level cache (L3) miss rate
```

**Expected results:**

| Version | L1d miss rate (approx) |
|---------|----------------------|
| `ijk`   | ~20–25% (B column misses dominate) |
| `ikj`   | ~5–8% (all sequential) |
| `jki`   | ~30–40% (A and C both column-strided) |
| `tiled` | ~5–8% (similar to ikj at this size) |

---

## 9. Connection to Other Members

| Member | Their work | How it connects to mine |
|--------|-----------|------------------------|
| Member 1 | Compiled same `ijk` code at `-O0` to `-O3` | My `ijk` version at `-O2` is the same baseline (3.31 s vs their ~2.36 s at `-O2` — small difference from machine variation). Their `-O3 -march=native` brings it to ~1.25 s; combine that with `ikj` loop order for maximum effect. |
| Member 2 | OpenMP parallel version, CUDA | Their OpenMP version parallelises the `ijk` loop — it would be even faster with `ikj` loop order (cache-friendly access per thread + no false sharing). |
| Member 4 | Benchmarking & timing | Uses the same `<chrono>` approach. My checksums match theirs, confirming correctness. |
| Member 5 | Integration | My `matmul_cache_opt.cpp` is self-contained and can be added directly to the CMakeLists.txt. |

---

## 10. Report-Ready Sections

### Section: Memory Access Patterns and Cache Performance

> Matrix multiplication's performance is dominated not only by the number of arithmetic operations, but by how efficiently data is retrieved from memory. Because matrices in C++ are stored in row-major order, the choice of loop order determines whether accesses are sequential (cache-friendly) or strided (cache-hostile).
>
> We tested four loop orders on a 1024×1024 double matrix, compiled at `-O2`. The textbook `ijk` order accesses column `j` of matrix B with a stride of 8 KB per step, producing an L1 cache miss on nearly every B load. By reordering the loops to `ikj`, the same column of B becomes a row walk (stride 8 bytes), and the scalar value `A[i,k]` is hoisted into a register outside the inner loop. This converts the bottleneck access from strided to sequential.
>
> The result: the `ikj` variant runs in 0.69 s versus 3.31 s for `ijk` — a **4.78× speedup** from loop reordering alone, with no change to the algorithm's O(n³) complexity and no parallelism. As a lower bound, the `jki` order (both A and C column-strided) takes 17.6 s — 25× slower than the optimized version. These results quantify the cost of cache misses: the `jki` version performs the same arithmetic but spends most of its time waiting for memory.
>
> We also implemented cache blocking (tiling) with a 64×64 tile size, keeping a 96 KB working set in L2 cache and reusing each tile across TILE iterations before eviction. This achieved a 4.49× speedup, matching `ikj` at this matrix size. For matrices too large to fit in L3, tiling would show a larger advantage.

### Key results table (for report)

| Version | Loop order | B access pattern | Time (s) | GFLOPS | Speedup |
|---------|-----------|-----------------|----------|--------|---------|
| Textbook (`ijk`) | i→j→k | Column walk, stride 8 KB | 3.31 | 0.65 | 1.00× |
| Optimized (`ikj`) | i→k→j | Row walk, stride 8 bytes | 0.69 | 3.10 | **4.78×** |
| Worst case (`jki`) | j→k→i | Scalar (hoisted) | 17.64 | 0.12 | 0.19× |
| Cache-blocked (tiled, 64×64) | blocked | Row walk within tile | 0.74 | 2.91 | **4.49×** |

All versions produce identical checksums, confirming correctness.

---

## 11. Oral Defense Q&A

**Q: "What is a cache miss, exactly?"**  
A: When the CPU asks for a memory address and that data isn't in L1 or L2 cache, it must fetch a 64-byte cache line from L3 or RAM. This stalls the CPU for ~12–200 cycles. In a tight inner loop, if every third instruction is a missed load, the arithmetic units sit idle waiting for data — compute throughput collapses.

**Q: "Why does reordering loops help if you're doing the same total number of multiplications?"**  
A: We're doing the same arithmetic but accessing the same data in a different sequence. In `ijk`, we access `B[0,j], B[1,j], B[2,j]...` — jumping 8 KB between each. Each jump evicts the previous cache line before we can reuse it. In `ikj`, we access `B[k,0], B[k,1], B[k,2]...` — moving forward 8 bytes per step. A single cache-line fetch covers 8 consecutive accesses. Same data, different order, 4.78× different speed.

**Q: "What is cache blocking / tiling?"**  
A: Instead of processing matrices row by row (which exhausts L2 before we can reuse data), we divide the matrices into small TILE×TILE blocks. For TILE=64, each set of three tile blocks fits in ~96 KB, which stays in L2. We finish all computation involving that tile before moving on — each piece of data is reused TILE times while it's still in cache. It's the same idea as reading a chapter of a book before moving to the next, rather than skipping between pages.

**Q: "Your `tiled` version is barely faster than `ikj`. Isn't tiling supposed to be better?"**  
A: At 1024×1024, matrices are 8 MB each. On our test machine, L3 is large enough that `ikj`'s sequential access pattern is well-served by the hardware prefetcher — it predicts ahead and hides most of the latency. Tiling provides the most benefit when the matrix is too large for L3 (e.g., 4096×4096 at 128 MB each). At that scale, `ikj` degrades but the tiled version maintains its speedup.

**Q: "How does this relate to Member 1's assembly analysis?"**  
A: Member 1 showed that `-march=native` enables AVX — processing 4 doubles at once. That multiplies throughput, but if B has a 100% L1 miss rate (as in `ijk`), the AVX units still stall waiting for data. Combining `ikj` loop order with `-march=native` would yield the maximum benefit: sequential access for the prefetcher + wide SIMD for the arithmetic units.

**Q: "How did you verify correctness?"**  
A: All four versions produce a checksum of 657,440,507,200 — identical to within floating-point tolerance. Since they compute the same mathematical operation from the same input, any deviation would indicate a bug in the loop indexing.

---

## Files

| File | Description |
|------|-------------|
| `matmul_cache_opt.cpp` | All four versions, timing, correctness check |
| `CACHE_REPORT.md` | This document |

Build and run:
```bash
g++ -std=c++17 -O2 matmul_cache_opt.cpp -o matmul_cache_opt
./matmul_cache_opt
```

For cache profiling on Linux/WSL:
```bash
valgrind --tool=cachegrind --cache-sim=yes ./matmul_cache_opt
cg_annotate cachegrind.out.<pid>
```
