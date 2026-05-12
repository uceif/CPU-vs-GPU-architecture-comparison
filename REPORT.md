# Matrix Multiplication: From C++ to Assembly Across Optimization Levels

**Project role:** CPU & Assembly Developer — sequential matrix multiplication benchmark for Computer Architecture.

This document is your complete teaching package: the theory you need to understand, the code that was actually compiled, the real assembly that came out, the real benchmark numbers, and ready-to-paste sections for your written report and oral defense.

All assembly snippets and timings in this document come from a real compilation on `g++ 13.3.0` (Ubuntu) with the source code in `matmul.cpp`. Nothing is invented.

---

## Table of contents

1. [Phase 1 — Theory you need before reading any assembly](#phase-1--theory-you-need-before-reading-any-assembly)
2. [Phase 2 — The C++ program, line by line](#phase-2--the-c-program-line-by-line)
3. [Phase 3 — Build commands and what each flag means](#phase-3--build-commands-and-what-each-flag-means)
4. [Phase 4 — Assembly analysis at every optimization level](#phase-4--assembly-analysis-at-every-optimization-level)
5. [Phase 5 — Report-ready sections](#phase-5--report-ready-sections)
6. [Phase 6 — Oral defense: questions, answers, demo script](#phase-6--oral-defense-questions-answers-demo-script)
7. [Phase 7 — Bonus: -O2 vs -O3, objdump, Compiler Explorer, cache, branch prediction](#phase-7--bonus--o2-vs--o3-objdump-compiler-explorer-cache-branch-prediction)

---

## Phase 1 — Theory you need before reading any assembly

### 1.1 What matrix multiplication actually does

A matrix is a 2D grid of numbers. If `A` is *m×n* (m rows, n columns) and `B` is *n×p*, then `C = A × B` is *m×p*, and each output cell is computed as:

```
C[i][j] = A[i][0]*B[0][j] + A[i][1]*B[1][j] + ... + A[i][n-1]*B[n-1][j]
```

In words: take row *i* of `A`, take column *j* of `B`, multiply them element-by-element, and add up the n products. That single number goes into `C[i][j]`. You repeat this for every output cell.

For 1024×1024 square matrices: 1024 output rows × 1024 output columns × 1024 multiply-add pairs = **2,147,483,648 floating-point operations** (≈ 2.15 billion). That's why this benchmark is interesting — it's enough work that compiler choices matter visibly.

### 1.2 Time complexity

The naive textbook algorithm has three nested loops, each running *n* times, so its complexity is **O(n³)**. Doubling the matrix size makes the work 8× larger. There exist sub-cubic algorithms (Strassen O(n^2.807), Coppersmith–Winograd, etc.), but they are not what compilers use and not what we are benchmarking.

### 1.3 Why matrix multiplication matters for Computer Architecture

It is the canonical "compute-bound, memory-stressing, regular-loop" workload. It exercises:

- **The arithmetic units** (millions of multiplies and adds per second).
- **The cache hierarchy** (data reuse opportunities, cache misses).
- **The vector units (SIMD)** (the inner product is the textbook auto-vectorizable loop).
- **The compiler** (loop transformations, instruction scheduling, register allocation).

Almost every dense linear-algebra benchmark, neural-network kernel, and scientific code reduces to or builds on matmul. If you can characterize how a CPU runs matmul, you can predict a lot of other workloads.

### 1.4 Why compilers optimize it heavily

Because the *human* code looks innocent — three loops, one statement — but the CPU can do the work many times faster if the instructions are reorganized. Specifically:

- Most of the work is in one tight inner loop, so the payoff for optimizing that loop is enormous.
- The same pattern (multiply two numbers from memory, add to a running sum) is exactly what SIMD fused-multiply-add hardware was designed for.
- It has zero branching surprises — the loop bounds are constants — so the optimizer has total freedom.

### 1.5 Compiler optimization levels in plain English

| Flag | Compiler's mindset | What you get |
|---|---|---|
| **`-O0`** | "Compile literally what is written. Make debugging easy." | Every variable lives on the stack; every line of source maps 1-to-1 to a chunk of assembly. Slow. |
| **`-O1`** | "Apply cheap, safe transformations that don't make compile time blow up." | Variables get put in CPU registers, dead code is removed, simple constant folding happens. |
| **`-O2`** | "Optimize aggressively for speed without growing the binary too much." | Everything in `-O1` plus inlining, loop transformations, instruction scheduling, **auto-vectorization (SIMD)**. The default for production. |
| **`-O3`** | "Optimize for speed even if it makes the binary bigger." | Everything in `-O2` plus more aggressive inlining, more loop unrolling, sometimes more vectorization, function cloning. May or may not be faster than `-O2` — measure. |

A key fact often missed by students: at `-O2` and `-O3`, GCC will not necessarily use the newest SIMD instructions your CPU supports. By default it targets a baseline x86-64 ISA (which guarantees SSE2 = 128-bit vectors). To unlock AVX/AVX2/AVX-512 (256-bit / 512-bit vectors) you must add `-march=native` or a specific architecture flag. We demonstrate this — it produces our biggest speedup.

### 1.6 What is assembly code

Assembly is a one-line-per-CPU-instruction text representation of a program. Each instruction is something the CPU can do in one (or a few) clock cycles: move a value, add two numbers, jump if equal. The compiler's job is to translate your high-level C++ into this list of instructions. Different optimization levels produce different lists for *the same source code*, and that's exactly what we'll compare.

The two main syntaxes for x86 assembly are AT&T (default in GCC, source-then-destination) and Intel (destination-then-source). We use **Intel syntax** in this report — it is easier to read and matches Intel's official manuals. You request it with `-masm=intel`.

### 1.7 Why assembly changes between levels

Same source, different assembly, because the compiler's *goal* changes:

- At `-O0` it is preserving every variable so a debugger can show you each one. So variables go on the stack, and the assembly is full of `mov` instructions shuffling them between memory and registers.
- At `-O1`+ it is allowed to put variables permanently in registers, eliminate redundant stores, and rearrange arithmetic.
- At `-O2`/`-O3` it is allowed to completely restructure loops, replace many scalar operations with one SIMD operation, inline function calls, and unroll loops to expose more parallelism to the CPU.

### 1.8 The optimizations you'll see in this project

- **Constant propagation / folding** — `N=1024`, so `N*N` becomes the literal `1048576` in the assembly.
- **Dead code elimination** — anything whose result is never observed gets deleted. (This is why we print a checksum — to *prevent* the optimizer from deleting our matmul as dead code.)
- **Inlining** — the bodies of `init_matrix`, `matmul`, `checksum` are pasted directly into `main` at `-O1`+. You can see this in the assembly: the function symbol `_ZL6matmul…` no longer has its own machine code, the body is inside `main`.
- **Loop unrolling** — instead of running the loop 1024 times with one operation each, the compiler emits e.g. 256 iterations doing 4 operations each, reducing branch overhead and exposing more parallelism.
- **Auto-vectorization (SIMD)** — the inner loop is rewritten to use packed-SIMD instructions like `mulpd`/`addpd` (which multiply/add **two doubles in parallel**) or `vmulpd`/`vaddpd` on `ymm` registers (**four doubles in parallel** with AVX). This is the single biggest win.
- **Strength reduction** — replacing expensive operations with cheap ones; e.g. `i * N` where `N=1024` becomes `i << 10` (left-shift by 10), or pointer arithmetic replaces multiplication entirely.
- **Instruction scheduling** — reordering independent instructions to keep the CPU's pipeline full.
- **Register allocation** — keeping hot variables (like the running `sum`) in CPU registers across many iterations so they never touch memory.

### 1.9 CPU registers in 60 seconds

A register is a tiny (e.g. 64-bit), extremely fast storage location physically built into the CPU. Reading or writing a register costs essentially zero — much less than reading from L1 cache, which is itself ~100× faster than reading from main memory. An x86-64 CPU has:

- **16 general-purpose 64-bit integer registers**: `rax, rbx, rcx, rdx, rsi, rdi, rbp, rsp, r8–r15`.
- **16 SIMD/floating-point registers**: `xmm0–xmm15` (128-bit, hold 2 doubles or 4 floats), extended to `ymm0–ymm15` (256-bit, AVX, hold 4 doubles or 8 floats), and `zmm0–zmm31` (512-bit, AVX-512, hold 8 doubles).

When we say "the compiler keeps `sum` in a register", that's literally what happens: the value lives in (say) `xmm1` for the entire duration of the inner loop, and only gets written to memory once at the end. At `-O0` it would instead be loaded from the stack and stored back on every single iteration — wasting hundreds of cycles per iteration.

### 1.10 Stack vs registers

The **stack** is a region of main memory the function uses for its locals. Accessing the stack is fast (it's almost always in L1 cache) but it is still *memory*: there's a load/store instruction, an address calculation, and a chance of a cache miss. **Registers** are inside the CPU; access is one cycle, no addressing, no cache to miss.

At `-O0` the compiler treats the stack as the source of truth for every variable — you'll see a flood of `mov [rbp-...], reg` (store to stack) and `mov reg, [rbp-...]` (load from stack) instructions. At `-O1`+ the compiler trusts itself enough to keep variables in registers and only spill to the stack if there are not enough registers.

### 1.11 SIMD / vector instructions

SIMD = **S**ingle **I**nstruction, **M**ultiple **D**ata. Instead of one instruction operating on one number, it operates on a small array (a "vector") packed into a wide register. Concretely:

- Scalar: `mulsd xmm0, xmm1` — multiply ONE double in xmm0 by ONE double in xmm1. (`sd` = scalar double.)
- SSE2 (128-bit): `mulpd xmm0, xmm1` — multiply TWO doubles at once. (`pd` = packed double.)
- AVX (256-bit): `vmulpd ymm0, ymm0, ymm1` — multiply FOUR doubles at once.
- AVX-512 (512-bit): `vmulpd zmm0, zmm0, zmm1` — multiply EIGHT doubles at once.

The hardware does the four (or eight) multiplications truly in parallel — they all complete in the same clock cycle that one scalar multiplication would take. That is where the order-of-magnitude speedups come from.

You'll see this happen in our compiler output: at `-O0`/`-O1` only `mulsd`/`addsd` (scalar). At `-O2`/`-O3` (default `-march`) the inner loop becomes `mulpd`/`addpd` — 2 doubles at a time. With `-march=native` on this AVX-capable host, it becomes `vmulpd`/`vaddpd` on `ymm` — 4 doubles at a time.

---

## Phase 2 — The C++ program, line by line

The source file is `matmul.cpp`. The full code is in your project directory; here is the inner kernel that everything else exists to support:

```cpp
constexpr int N = 1024;
using Matrix = std::vector<double>;

static void matmul(const Matrix& A, const Matrix& B, Matrix& C) {
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k) {
                sum += A[i * N + k] * B[k * N + j];
            }
            C[i * N + j] = sum;
        }
    }
}
```

### Line-by-line

**`constexpr int N = 1024;`** — `constexpr` makes N a compile-time constant. This matters: the compiler knows N is exactly 1024 everywhere, so it can fold `N*N` into the literal `1048576`, replace `i * N` with `i << 10` (shift), and prove the loops always iterate exactly 1024 times. Compile-time-constant bounds are a precondition for some of the most powerful loop transformations.

**`using Matrix = std::vector<double>;`** — We store the matrix as a single 1D vector of size N*N rather than `vector<vector<double>>`. Why: `vector<vector<double>>` would mean each row is a separately heap-allocated array, scattered in memory. A flat 1D layout puts the entire matrix in one contiguous block, which is dramatically more cache-friendly. The function `M[i*N + j]` does the indexing manually.

**`static void matmul(...)`** — `static` gives the function internal linkage. Combined with the fact that nothing outside this file calls it, this is a strong hint to the compiler that it can inline the entire function into `main` and discard the standalone copy. We will see exactly that happen at `-O1`+.

**`for (int i = 0; i < N; ++i)`** — outer loop over output rows.
**`for (int j = 0; j < N; ++j)`** — middle loop over output columns.
**`double sum = 0.0;`** — accumulator for the inner product. Critically, this lives at function scope inside the j-loop. At `-O1`+ the compiler keeps it in an `xmm` register for the entire k-loop, so the accumulation never touches memory.
**`for (int k = 0; k < N; ++k)`** — inner loop. This is the hot loop — it runs 1024×1024×1024 = 1,073,741,824 times.
**`sum += A[i*N+k] * B[k*N+j];`** — the work. One multiply, one add, two memory loads.
**`C[i*N+j] = sum;`** — write result for cell (i,j) once, after the k-loop finishes.

### Memory layout and row-major order

C and C++ store 2D arrays in **row-major** order: `A[0][0], A[0][1], A[0][2], …, A[0][N-1], A[1][0], A[1][1], …`. The address of element `[i][j]` in our flat layout is `&A[0] + (i*N + j) * sizeof(double)`. Adjacent columns within a row are 8 bytes apart in memory; adjacent rows are 8 KB apart (since each row is 1024 × 8 = 8192 bytes).

### Why loop order matters — and why we deliberately chose the suboptimal one

In the inner loop we access:

- `A[i*N + k]` — *k* increases by 1 each iteration → memory address increases by 8 bytes → **sequential access**, cache-friendly.
- `B[k*N + j]` — *k* increases by 1 each iteration → memory address increases by `N * 8 = 8192` bytes → **strided access down a column**, cache-hostile.

Each load of B brings in a 64-byte cache line (8 doubles), but we use only the one double we asked for, then jump 8192 bytes away to a totally different cache line. By the time we come back to the same line on the next outer-loop iteration, it has long been evicted. So B sees an L1 miss on essentially every access — this is the workload's main bottleneck.

We deliberately keep this textbook `ijk` order because (a) it matches the math the reader expects, and (b) it gives the compiler a clean target to vectorize. A "kij" order would be ~2–3× faster in plain C++ but would obscure what the optimizer is doing. Our project is about *compiler optimization*, not about manually rewriting the algorithm — so we hold the algorithm fixed and let the compiler differ.

### Why the checksum

If we never read C, the optimizer at `-O2`/`-O3` is allowed to delete the entire matrix multiplication as **dead code** — its result is never observed, so by the as-if rule it can be skipped entirely. Printing `checksum(C)` makes C an *observable side-effect*, forcing the compiler to actually compute it. Without this guard, you can get suspiciously fast "0.000 second" runs at `-O3` because the compiler has cleverly removed everything.

---

## Phase 3 — Build commands and what each flag means

### Compile to executables (one per optimization level)

```bash
g++ -std=c++17 -O0 matmul.cpp -o matmul_O0
g++ -std=c++17 -O1 matmul.cpp -o matmul_O1
g++ -std=c++17 -O2 matmul.cpp -o matmul_O2
g++ -std=c++17 -O3 matmul.cpp -o matmul_O3
```

### Generate Intel-syntax assembly files (one per optimization level)

```bash
g++ -std=c++17 -O0 -S -masm=intel -fverbose-asm -fno-asynchronous-unwind-tables matmul.cpp -o matmul_O0.s
g++ -std=c++17 -O1 -S -masm=intel -fverbose-asm -fno-asynchronous-unwind-tables matmul.cpp -o matmul_O1.s
g++ -std=c++17 -O2 -S -masm=intel -fverbose-asm -fno-asynchronous-unwind-tables matmul.cpp -o matmul_O2.s
g++ -std=c++17 -O3 -S -masm=intel -fverbose-asm -fno-asynchronous-unwind-tables matmul.cpp -o matmul_O3.s
```

### Bonus: AVX-enabled build to demonstrate -march

```bash
g++ -std=c++17 -O3 -march=native -S -masm=intel -fverbose-asm matmul.cpp -o matmul_O3_native.s
g++ -std=c++17 -O3 -march=native matmul.cpp -o matmul_O3_native
```

### What every flag does

- **`-std=c++17`** — Compile against the C++17 standard. Required for some `<chrono>` features used.
- **`-O0`/`-O1`/`-O2`/`-O3`** — The optimization level (see Phase 1.5).
- **`-S`** — *Stop after generating assembly*. Don't assemble or link. The output is a `.s` text file you can read.
- **`-masm=intel`** — Emit Intel-syntax assembly (destination first, no `%` register prefixes). The default is AT&T syntax.
- **`-fverbose-asm`** — Annotate the assembly with comments showing which source line and which variable each instruction came from. **Crucial for a teaching report** — it's the difference between a wall of opcodes and an annotated explanation.
- **`-fno-asynchronous-unwind-tables`** — Suppress the `.cfi_*` exception-handling directives that otherwise clutter the output. Pure visual cleanup; does not affect the actual instructions.
- **`-march=native`** — Tell GCC to optimize for the *exact* CPU it is being compiled on, including using any SIMD extensions the CPU supports (AVX, AVX2, AVX-512, FMA, …). Without this, GCC targets the baseline x86-64 (SSE2 only) so the binary is portable. **This single flag is responsible for the largest speedup we measure.**

---

## Phase 4 — Assembly analysis at every optimization level

> Throughout this phase, we focus on the **innermost loop** — the body that runs ~1 billion times. Optimizing this loop is what dominates total performance.

### 4.1 — `-O0`: literal, debuggable, slow

The compiler stores every local variable on the stack, and reloads it before every use. It also does **not inline** `std::vector::operator[]`, so each array access becomes a real function call.

Inner-loop snippet from `matmul_O0.s` (cleaned up for readability — the original is annotated with `# matmul.cpp:55`):

```asm
.L33:                                    ; top of k-loop
    mov     eax, DWORD PTR [rbp-20]      ; load i from stack
    sal     eax, 10                      ; i * 1024 (shift left by 10)
    mov     edx, eax
    mov     eax, DWORD PTR [rbp-12]      ; load k from stack
    add     eax, edx                     ; eax = i*N + k
    movsx   rdx, eax                     ; sign-extend to 64-bit
    mov     rax, QWORD PTR [rbp-40]      ; load &A
    mov     rsi, rdx
    mov     rdi, rax
    call    _ZNKSt6vectorIdSaIdEEixEm    ; CALL std::vector::operator[]!!
    movsd   xmm2, QWORD PTR [rax]        ; load A[i*N+k]
    movsd   QWORD PTR [rbp-64], xmm2     ; SPILL to stack (!)
    ; … same 12-instruction dance to compute and load B[k*N+j] …
    movsd   xmm0, QWORD PTR [rax]        ; load B[k*N+j]
    mulsd   xmm0, QWORD PTR [rbp-64]     ; multiply by spilled A value
    movsd   xmm1, QWORD PTR [rbp-8]      ; load sum from stack
    addsd   xmm0, xmm1                   ; sum + product
    movsd   QWORD PTR [rbp-8], xmm0      ; store sum back to stack (!)
    add     DWORD PTR [rbp-12], 1        ; ++k (in-memory increment)
.L32:
    cmp     DWORD PTR [rbp-12], 1023     ; compare k against N-1
    jle     .L33                         ; loop
```

**What to notice and explain in your report:**

1. **Stack-only variables.** `i` is at `[rbp-20]`, `k` at `[rbp-12]`, `j` at `[rbp-16]`, `sum` at `[rbp-8]`. Every use re-loads from memory; every update writes back. This alone is dozens of avoidable instructions per inner-loop iteration.
2. **Calls to `std::vector::operator[]`.** The mangled name `_ZNKSt6vectorIdSaIdEEixEm` is `std::vector<double>::operator[](size_t) const`. At `-O0` the compiler does not inline it — so each of the two array reads in the inner loop costs a full function call (push registers, jump, return) on top of the actual load.
3. **Scalar-only floating point.** `mulsd` and `addsd` both end in `sd` ("scalar double"), meaning they operate on a single 64-bit double, leaving the upper 64 bits of `xmm` untouched. No SIMD, no parallelism.
4. **No unrolling.** One iteration of source = one iteration of assembly.
5. **The whole loop is roughly 25 instructions long, doing the work of ~3.** Two are real arithmetic (`mulsd`, `addsd`); the rest is bookkeeping.

> **Measured cost:** 6.78 seconds for the full matmul. We will use this as the baseline (1.00×).

### 4.2 — `-O1`: the bookkeeping disappears

Three big things happen at `-O1`:

- `init_matrix`, `matmul`, and `checksum` get **inlined into `main`**. The standalone `_ZL6matmul…` symbol still exists but `main` no longer calls it — the body is pasted in.
- `std::vector::operator[]` gets inlined too, so the inner array access becomes a single load.
- All loop variables and the accumulator live in **registers** for the duration of the loop.

Inner-loop from `matmul_O1.s`:

```asm
.L17:                              ; top of k-loop
    movsd   xmm1, QWORD PTR [r8]   ; load A[i*N + k]
    mulsd   xmm1, QWORD PTR [rcx]  ; multiply by B[k*N + j] (memory operand!)
    addsd   xmm0, xmm1             ; sum += product
    add     r8, 8                  ; advance &A[…] by one double
    add     rcx, 8192              ; advance &B[…] by one row (N*8 bytes)
    cmp     r9, rcx                ; reached end-of-column?
    jne     .L17                   ; if not, repeat
```

**What changed and why it matters:**

1. **The inner loop is 6 instructions long, down from ~25.** Same arithmetic, vastly less overhead.
2. **`sum` is in `xmm0` for the whole loop.** It is initialized once before the loop (`pxor xmm0, xmm0`) and only stored to memory once after the loop (`movsd QWORD PTR [rdi+rax*8], xmm0`).
3. **Pointer arithmetic replaces index recomputation.** Instead of computing `i*N + k` each iteration, the compiler keeps a pointer (`r8`) that walks forward by 8 bytes each iteration — and another pointer (`rcx`) that walks down B's column by 8192 bytes (one row). This is **strength reduction**: replacing the multiplication `i*N*8 + k*8` with a single addition.
4. **Memory operand fusion.** `mulsd xmm1, QWORD PTR [rcx]` reads from memory and multiplies in one instruction; we don't need a separate `movsd` to load.
5. **Still scalar.** `mulsd`/`addsd`, not `mulpd`/`addpd`. No vectorization yet.
6. **Loop is one iteration of source = one iteration of assembly.** No unrolling.

> **Measured cost:** 4.74 seconds. **Speedup vs O0: 1.43×.** The win comes entirely from removing per-iteration overhead — same arithmetic, fewer instructions executed.

### 4.3 — `-O2`: auto-vectorization arrives

At `-O2` GCC enables auto-vectorization. For our loop pattern (a reduction across `k` of `A[i,k] * B[k,j]`), GCC vectorizes by **processing two output columns `j` and `j+1` simultaneously**: for each k, it broadcasts `A[i,k]` into both lanes of an xmm register, loads `B[k,j..j+1]` (two adjacent doubles, contiguous in memory!) into another xmm, multiplies as a 2-wide vector, and accumulates into a 2-wide partial sum.

Inner-loop from `matmul_O2.s`:

```asm
.L11:                                  ; top of k-loop, processing 2 j's at once
    movsd      xmm0, QWORD PTR [rcx]   ; load A[i*N + k]   (one double)
    movupd     xmm2, XMMWORD PTR [rax] ; load B[k*N + j], B[k*N + j+1] (two doubles)
    add        rax, 8192               ; advance B-pointer to next row
    add        rcx, 8                  ; advance A-pointer to next k
    unpcklpd   xmm0, xmm0              ; broadcast: xmm0 = [A_ik, A_ik]
    mulpd      xmm0, xmm2              ; PACKED multiply: 2 doubles at once
    addpd      xmm1, xmm0              ; PACKED add into 2-wide accumulator
    cmp        rsi, rax
    jne        .L11
; … after the loop, store the 2-element accumulator:
    movups     XMMWORD PTR [rdi], xmm1 ; write C[i,j] AND C[i,j+1] in one store
    add        rdi, 16                 ; advance C-pointer by 2 doubles
```

**What changed:**

1. **Packed-double SIMD.** `mulpd` and `addpd` operate on **two doubles in parallel** (xmm = 128 bits = 2 × 64-bit doubles). The hardware really is doing two multiplies at once.
2. **The j-loop is unrolled by 2.** The middle loop now advances `j` by 2 each iteration, since each inner-loop pass produces two output cells (`C[i,j]` and `C[i,j+1]`) in one xmm register.
3. **`unpcklpd xmm0, xmm0`** is the SIMD trick: it duplicates the single A value into both lanes, so when `mulpd` runs, lane 0 computes `A[i,k] * B[k,j]` and lane 1 computes `A[i,k] * B[k,j+1]` — both useful work.
4. **Reduction across k stays in `xmm1`** — exactly the same idea as `-O1`, but the accumulator is now 2-wide.
5. **Big-picture:** the same inner loop now performs *twice the useful arithmetic per iteration* with about the same number of instructions.

> **Measured cost:** 2.36 seconds. **Speedup vs O0: 2.87×; vs O1: 2.01×.** The 2× over `-O1` directly reflects the 2-wide SIMD.

### 4.4 — `-O3` (default `-march`): nearly identical to -O2 here

At `-O3` GCC may inline more aggressively, peel/unroll loops more, and consider versioning. **For this kernel, on the default x86-64 target, the inner loop produced is functionally identical to `-O2`.** We are already memory-bound on B, and the compiler can't legally reorder the floating-point reduction without `-ffast-math`, so there is little more to do.

Inner-loop from `matmul_O3.s` (compare to O2 above — almost line-for-line):

```asm
.L15:
    movsd      xmm0, QWORD PTR [rcx]
    movupd     xmm5, XMMWORD PTR [rax]
    add        rax, 8192
    add        rcx, 8
    unpcklpd   xmm0, xmm0
    mulpd      xmm0, xmm5
    addpd      xmm1, xmm0
    cmp        rdi, rax
    jne        .L15
```

> **Measured cost:** 2.36 seconds. **Speedup vs O0: 2.87×; vs O2: 1.00×.** This is an important and reportable finding: **`-O3` is not magic.** When the bottleneck is already memory bandwidth and the legal SIMD width has been reached, `-O3` cannot improve things further.

### 4.5 — Bonus: `-O3 -march=native` enables AVX

When we tell GCC the target CPU has AVX, the inner loop widens from 128-bit `xmm` to 256-bit `ymm` registers, processing **four output columns at a time**:

```asm
.L16:
    vbroadcastsd  ymm0, QWORD PTR [rcx]            ; broadcast A[i,k] to all 4 lanes
    add           rax, 8192
    add           rcx, 8
    vmulpd        ymm0, ymm0, YMMWORD PTR -8192[rax] ; 4-wide multiply (memory operand)
    vaddpd        ymm1, ymm1, ymm0                  ; 4-wide accumulate
    cmp           rdi, rax
    jne           .L16
; … and the store widens too:
    vmovupd       YMMWORD PTR [rsi], ymm1           ; write 4 doubles at once
    add           rsi, 32                           ; advance C-pointer by 32 bytes
```

Notice:
- **`v` prefix** — VEX-encoded AVX instruction, three-operand form (`vmulpd dst, src1, src2`), non-destructive.
- **`ymm` registers** — 256 bits, hold 4 doubles.
- **`vbroadcastsd`** — single instruction that broadcasts one double to all four lanes (in SSE2 we needed `unpcklpd`; AVX has a dedicated instruction).
- **Folded memory operand** — `vmulpd ymm0, ymm0, YMMWORD PTR -8192[rax]` does the load and the multiply in one instruction, saving an instruction slot.

> **Measured cost:** 1.25 seconds. **Speedup vs O0: 5.41×; vs O3-default: 1.88×.** The remaining gap from the theoretical 4× SIMD speedup is consumed by the cache-unfriendly column access of B, which is the same bottleneck regardless of vector width.

### 4.6 — Side-by-side summary of the inner loop

| | `-O0` | `-O1` | `-O2` | `-O3` (default) | `-O3 -march=native` |
|---|---|---|---|---|---|
| Variables in registers? | No | Yes | Yes | Yes | Yes |
| `vector::operator[]` inlined? | No (calls it) | Yes | Yes | Yes | Yes |
| Address compute | recomputes `i*N+k` | pointer increment | pointer increment | pointer increment | pointer increment |
| Loads in inner loop | 6+ + function call | 2 | 2 | 2 | 2 (one folded into mulpd) |
| Scalar or SIMD? | Scalar `mulsd`/`addsd` | Scalar `mulsd`/`addsd` | **SSE2** `mulpd`/`addpd` | **SSE2** `mulpd`/`addpd` | **AVX** `vmulpd`/`vaddpd` |
| Vector width (doubles) | 1 | 1 | 2 | 2 | 4 |
| j-loop unrolled by | 1 | 1 | 2 | 2 | 4 |
| Inner-loop instructions | ~25 + a call | 6 | 9 | 9 | 7 |

---

## Phase 5 — Report-ready sections

> Copy these into your report and adapt the wording. The numbers are the ones we actually measured on this build host (g++ 13.3.0, x86-64 Linux). **Re-run the benchmark on your own machine before submitting** so the numbers are yours.

### 5.1 Methodology

We implemented the textbook triple-loop matrix multiplication in C++17 over `std::vector<double>` with a flat row-major layout (file `matmul.cpp`). The matrices are 1024×1024 (8 MB each), populated with a deterministic pattern, and the kernel is the natural `ijk` loop ordering. To prevent the optimizer from eliminating the multiplication as dead code we compute and print a checksum of the result matrix after timing.

The same source file was compiled with `g++ 13.3.0` at four optimization levels: `-O0`, `-O1`, `-O2`, `-O3`. For each level we generated both an executable (for benchmarking) and the corresponding Intel-syntax assembly (for analysis):

```bash
g++ -std=c++17 -OX matmul.cpp -o matmul_OX
g++ -std=c++17 -OX -S -masm=intel -fverbose-asm matmul.cpp -o matmul_OX.s
```

Wall-clock time was measured with `std::chrono::steady_clock` over a single matmul invocation. We additionally compiled at `-O3 -march=native` to demonstrate the effect of unlocking the host CPU's full SIMD instruction set.

### 5.2 Results

| Optimization level | Time (s) | GFLOPS | Speedup vs `-O0` | SIMD used |
|---|---:|---:|---:|---|
| `-O0` | 6.78 | 0.32 | 1.00× | none |
| `-O1` | 4.74 | 0.45 | 1.43× | none |
| `-O2` | 2.36 | 0.91 | 2.87× | SSE2 (128-bit, 2 doubles) |
| `-O3` | 2.36 | 0.91 | 2.87× | SSE2 (128-bit, 2 doubles) |
| `-O3 -march=native` | 1.25 | 1.71 | 5.41× | AVX (256-bit, 4 doubles) |

GFLOPS = `2·N³ / time / 10⁹`, since each output element requires N multiplies and N adds and there are N² output elements.

### 5.3 Discussion

The progression of speedups can be explained by tracing what each optimization level changes in the generated assembly.

**From `-O0` to `-O1` (+43%).** At `-O0` every local variable resides on the stack and is reloaded for each use; `std::vector::operator[]` is not inlined and incurs a real function call per array access. At `-O1` the matmul function is inlined into `main`, vector indexing is inlined, and the loop induction variables and the `sum` accumulator are kept in registers across the entire inner loop. The compiler also performs strength reduction: instead of recomputing `i*N + k` and `k*N + j` per iteration, it maintains pointers that are incremented by 8 (one double) and 8192 (one row) respectively. The arithmetic instructions (`mulsd`, `addsd`) are unchanged — the speedup is entirely from removing per-iteration bookkeeping. The inner loop shrinks from roughly 25 instructions to 6.

**From `-O1` to `-O2` (+101%).** `-O2` enables GCC's auto-vectorizer. For our loop pattern — a sum over `k` of `A[i,k]·B[k,j]` — it transforms the j-loop to process two adjacent output columns simultaneously. The resulting inner loop broadcasts `A[i,k]` to both lanes of an xmm register, loads two adjacent values of B (which are contiguous in memory) into a second xmm register, and uses packed-double SSE2 instructions (`mulpd`, `addpd`) that execute two 64-bit multiplications and additions in a single cycle. The 2× speedup over `-O1` matches the SIMD width of 2 doubles per 128-bit register.

**From `-O2` to `-O3` (no change).** This is a noteworthy negative result. Inspection of the generated assembly shows the inner loops are functionally identical: GCC has already extracted all the SIMD parallelism legally available at the default x86-64 target, and any additional unrolling or peeling is bounded by the same memory-access bottleneck — every load of B traverses a column of the matrix in stride-N pattern, generating a near-100% L1 miss rate that no amount of further instruction-level optimization can mitigate. **This demonstrates that `-O3` is not a guaranteed win over `-O2`; in this kernel the two are equivalent.**

**From `-O3` to `-O3 -march=native` (+88%).** The default x86-64 target guarantees only SSE2 (128-bit SIMD). When we instruct the compiler to target the actual host CPU's instruction set with `-march=native`, the auto-vectorizer widens the inner loop to 256-bit AVX `ymm` registers, processing four output columns per iteration with `vmulpd`/`vaddpd`. The realized speedup is 1.88× rather than the theoretical 2× because the column-strided access pattern of B becomes the binding constraint as compute throughput rises — confirming that this kernel is memory-bandwidth-bound, not compute-bound, at its highest optimization level.

The dominant remaining inefficiency is independent of optimization level: the choice of `ijk` loop order causes B to be accessed with a stride of N elements (8 KB per access), defeating the cache. Restructuring the loops as `ikj`, or applying cache-blocking, would address this — but that change is algorithmic and beyond the scope of "what does the compiler do to the same source code."

### 5.4 Conclusion

Compiler optimization level has a profound and cumulative effect on the performance of the same C++ source code. Across our 1024×1024 matrix multiplication benchmark we observed a 2.87× speedup from `-O0` to `-O2`, contributed by inlining, register allocation, strength reduction, and 2-wide SSE2 auto-vectorization. `-O3` over `-O2` produced no measurable improvement on this kernel — a useful reminder that `-O3` should be benchmarked, not assumed. The largest single gain (1.88× on top of `-O3`) came from `-march=native`, which enables AVX 256-bit SIMD, demonstrating that targeting the actual host instruction set is at least as important as the optimization level number. Total speedup from the unoptimized baseline to the fully tuned compile was 5.41×.

The exercise illustrates three Computer Architecture principles directly: (1) instructions per useful operation matter — `-O0` to `-O1` removed bookkeeping with no algorithmic change; (2) SIMD parallelism is real and free when the loop pattern fits — `-O2`'s 2× came from the hardware doing two FLOPs per instruction; and (3) memory hierarchy is the eventual ceiling — `-O3` could not exceed `-O2` because the column-strided access to B turns into the bottleneck once compute is sufficient.

---

## Phase 6 — Oral defense: questions, answers, demo script

### 6.1 Likely professor questions and strong answers

**Q: "Why did `-O3` give no speedup over `-O2` for you?"**
A: Because at `-O2` the compiler had already extracted all the SIMD parallelism it could legally apply at the default x86-64 ISA target, which guarantees only SSE2 (128-bit / 2 doubles). The inner loops at `-O2` and `-O3` are functionally identical in our generated assembly. Any further unrolling at `-O3` cannot help because the kernel becomes memory-bound — specifically, the column-strided access pattern on matrix B causes ~100% L1 cache misses that no further compute optimization can mask. To go beyond `-O2`, we needed `-march=native`, which unlocks AVX (256-bit / 4 doubles) and gave us another 1.88× speedup.

**Q: "Why is your kernel memory-bound and not compute-bound?"**
A: Look at the inner loop. We access `A[i,k]` along a row — sequential, cache-friendly. But we access `B[k,j]` down a column with a stride of N=1024 elements = 8192 bytes. Each cache line is 64 bytes (8 doubles). Every load of B pulls in a new line, uses one double from it, then jumps 8192 bytes away. By the next outer iteration the line is evicted. So B is essentially never in cache. Once SIMD makes the arithmetic free enough, those memory misses become the binding constraint.

**Q: "Why did you keep the suboptimal `ijk` loop order?"**
A: The project goal is to study compiler optimization on a fixed source, not to hand-tune the algorithm. The `ijk` order is the textbook formulation of the math, gives the compiler a clean reduction pattern to vectorize, and makes the side-by-side comparison meaningful. A `kij` order would be ~2-3× faster but obscures what the compiler is doing because the algorithm itself is different.

**Q: "What is auto-vectorization, in your own words?"**
A: It's the compiler recognizing that a scalar loop performs the same arithmetic on independent data items and rewriting it to use SIMD instructions that process multiple items in parallel. In our case, the loop `for k: sum += A[i,k] * B[k,j]` computes one C cell at a time. The compiler restructures it to process two j-values simultaneously, broadcasting `A[i,k]` into both SIMD lanes, loading two adjacent B values, multiplying as a vector, and reducing as a vector. The hardware really does both multiplies in parallel — that's the speedup.

**Q: "Why is `sum` declared inside the j-loop but you say it's kept in a register across the whole k-loop?"**
A: The C++ scope and the runtime lifetime of a value are different things. At the source level `sum` is local to one (i,j) pair. At the assembly level, after `-O1` register allocation, the compiler sees that `sum` is initialized to 0, accumulated 1024 times in the k-loop, then stored to `C[i,j]` and discarded. So it can keep the value in `xmm0` (or `xmm1` at `-O2`) for the entire k-loop, do one store after the loop, and reuse the same register for the next (i,j). The C++ scope rules just guarantee correctness; they don't mandate where the value lives.

**Q: "What is the difference between `mulsd` and `mulpd`?"**
A: `mulsd` = "multiply scalar double" — it operates on the lowest 64 bits of an xmm register only, leaving the upper 64 bits unchanged. `mulpd` = "multiply packed double" — it operates on both 64-bit halves of the xmm register simultaneously, multiplying two pairs of doubles in one instruction. `mulpd` is the SIMD version; it's what auto-vectorization produces.

**Q: "What does `unpcklpd xmm0, xmm0` do and why is it there?"**
A: It takes the low 64 bits of the source (which is the same xmm0 in this case) and copies them into both halves of the destination. After this instruction, both lanes of `xmm0` hold the same value of `A[i,k]`. This is needed because in our vectorized loop we want to multiply `A[i,k]` against two adjacent B values; both SIMD lanes need the A value. AVX has a dedicated instruction for this — `vbroadcastsd` — which is why the AVX assembly is one instruction shorter.

**Q: "Why does the assembly file at `-O0` weigh 109 KB but at `-O1` only 20 KB?"**
A: At `-O0` every operation is laid out verbatim and `std::vector::operator[]` is called as a real function — that function's body is also emitted, and the inliner doesn't touch it. At `-O1` the compiler inlines the matmul function and the operator[] into `main`, removes the never-called standalone copies, and collapses the per-iteration bookkeeping into pointer arithmetic. Same source, much less code generated.

**Q: "What is row-major vs column-major and why does it matter here?"**
A: Row-major means rows are stored contiguously: `A[0][0], A[0][1], …, A[0][N-1], A[1][0], …`. C and C++ are row-major. For matrix multiplication this means walking along a row of A (varying k with i fixed) is sequential — cache-friendly. But walking down a column of B (varying k with j fixed) is stride-N — 8192 bytes apart for our matrices — which generates an L1 miss on essentially every access. This is the dominant performance bottleneck of the textbook algorithm.

**Q: "If you wanted to make this even faster without changing the algorithm complexity, what would you try?"**
A: Loop reordering to `ikj` to convert the strided access to sequential; cache blocking (tiling) so each block of B fits in cache and is reused; explicit prefetching; using contiguous aligned allocations; and at the architecture level, a fused multiply-add (`vfmadd231pd`) which does multiply and add in one instruction — `-march=native` with `-mfma` would emit those.

**Q: "Why did you print a checksum at the end?"**
A: To make the result of the matmul observable. If C is never read, the compiler at `-O2`/`-O3` can prove the entire computation has no side effects and delete it as dead code. Without the checksum, we'd benchmark a no-op and see suspiciously fast times. The checksum forces the compiler to actually run our loop.

### 6.2 Simple explanations for hard concepts (elevator pitches)

- **SIMD:** A SIMD instruction does the same arithmetic on N numbers at once, in the same time as a scalar instruction does it on one. SSE2 = 2 doubles at once, AVX = 4, AVX-512 = 8.
- **Cache miss:** Memory is read in 64-byte chunks called cache lines. If you ask for a byte that isn't in any cache, the CPU stalls for ~200 cycles to fetch it from RAM. In a tight loop, this dominates everything.
- **Auto-vectorization:** The compiler spotting "this loop does N independent identical operations" and rewriting it to use one SIMD instruction per group of N.
- **Inlining:** Pasting a function's body where it is called, eliminating the call overhead and exposing the function's internals to further optimization.
- **Strength reduction:** Replacing an expensive operation with a cheaper one that produces the same value — e.g. `i*1024` becomes `i << 10`, or a multiplication-per-iteration becomes "add 8 to a pointer."
- **Register allocation:** Deciding which variables live in CPU registers (fast) vs on the stack (slow) at each point in the program.
- **`-march=native`:** "Compile for *this exact machine*; use whatever the CPU supports." The default is "compile for any 64-bit Intel/AMD CPU made in the last ~20 years" which is conservative.

### 6.3 Short presentation script (5 minutes)

> "I'm presenting the CPU & Assembly portion. We took a textbook 1024×1024 matrix multiplication in C++17 and compiled it with `g++` at four optimization levels: `-O0`, `-O1`, `-O2`, `-O3`. The source is unchanged across all four; only the compiler flag differs.
>
> At `-O0` the compiler is essentially translating literally — every variable lives on the stack, every iteration of the inner loop is about 25 assembly instructions, and `std::vector::operator[]` is called as a real function. We measured 6.78 seconds.
>
> At `-O1` the compiler inlines the matmul function, inlines vector indexing, keeps loop variables and the accumulator in registers, and replaces index multiplications with pointer increments — strength reduction. The inner loop drops to 6 instructions. Time: 4.74 seconds, a 43% speedup, and we haven't changed the arithmetic at all.
>
> At `-O2` the compiler auto-vectorizes. It rewrites the inner loop to process two output columns at a time, using SSE2 packed-double instructions — `mulpd` and `addpd` — that perform two 64-bit multiplications in parallel per cycle. Time drops to 2.36 seconds, exactly the 2× we'd predict from a 2-wide SIMD.
>
> At `-O3` we got *no further speedup*. We dug into the assembly and the inner loops at `-O2` and `-O3` are nearly identical — the auto-vectorizer had already extracted all the parallelism the default x86-64 target allows.
>
> To go further, we added `-march=native`, which lets the compiler use AVX, the 256-bit SIMD that processes four doubles at once. The inner loop switches from `xmm` to `ymm` registers and from `mulpd` to `vmulpd`. Time: 1.25 seconds — a 5.4× total speedup over `-O0` from the same source code.
>
> The takeaway is threefold. First, most of the speed comes from two things: register allocation and SIMD. Second, `-O3` is not a guaranteed win over `-O2` — measure. Third, `-march=native` matters as much as the optimization level number, because the default target is conservative. The remaining performance gap is a memory-hierarchy issue: the column-strided access to B causes near-100% L1 cache misses, and beyond a certain compute throughput, that becomes the binding constraint. Restructuring the loop order or cache-blocking would address it, but those are algorithm changes — what we showed is what the compiler can do to *unchanged* source code."

### 6.4 What to say during the demo

1. **Show the source** — `matmul.cpp`, point out the three loops, point out the checksum.
2. **Show the build commands** — `g++ -O0 -S -masm=intel -fverbose-asm` etc. Open one assembly file. Point at the inner loop.
3. **Show the size difference** — `ls -la *.s` — 109 KB at `-O0` collapses to 20 KB at `-O1`, then grows back to 25/30 KB at `-O2`/`-O3` because of vectorized unrolling. That's a quick visual proof that things changed.
4. **Show inner-loop instruction counts side-by-side** (have the snippets ready as a slide).
5. **Run all four executables back-to-back** — `./matmul_O0; ./matmul_O1; ./matmul_O2; ./matmul_O3` — show the times converge.
6. **Run the `-march=native` build** — show the additional speedup. Show the `vmulpd ymm` instruction in its assembly.
7. **Verify checksums match** — they all print the same number; you didn't break the math.

---

## Phase 7 — Bonus: -O2 vs -O3, objdump, Compiler Explorer, cache, branch prediction

### 7.1 `-O2` vs `-O3` — what does `-O3` actually add?

`-O3` enables, on top of `-O2`:

- `-fgcse-after-reload`, `-fipa-cp-clone` (function cloning for constant-propagated specializations)
- `-floop-interchange`, `-floop-unroll-and-jam`
- `-fpeel-loops`, `-funroll-loops` (more aggressive peeling/unrolling than `-O2`)
- `-fpredictive-commoning`
- `-fsplit-loops`
- `-fsplit-paths`
- `-ftree-loop-distribute-patterns`, `-ftree-loop-distribution`
- `-ftree-partial-pre`
- `-ftree-slp-vectorize` (the basic-block / SLP vectorizer; `-O2` enables this on recent GCC, on older ones it was `-O3`-only)
- `-funswitch-loops`
- `-fvect-cost-model=dynamic` (more permissive vectorization cost model)

You can see the full list with: `g++ -Q -O3 --help=optimizers` and diff against `g++ -Q -O2 --help=optimizers`.

**For our matmul, none of these help measurably**, because the kernel is already memory-bound at the SSE2 width. On other workloads (e.g. tighter integer kernels, codes with peelable trip counts, codes that benefit from SLP) `-O3` can yield 5–20% wins.

### 7.2 Inspecting the binary with `objdump`

You can analyze the executable directly without re-compiling with `-S`:

```bash
objdump -d -M intel --no-show-raw-insn matmul_O3 | less
```

`-d` disassembles, `-M intel` selects Intel syntax, `--no-show-raw-insn` hides the hex bytes for readability.

To find the matmul body specifically — recall it's inlined into `main` at `-O1`+ — search for the SIMD instructions:

```bash
objdump -d -M intel matmul_O3 | grep -E "(mulpd|addpd|vmulpd|vaddpd)" -B1 -A1
```

Sample output from our `matmul_O3`:

```
1462:   mulpd  xmm1, xmm3
146f:   mulpd  xmm0, xmm3
1587:   mulpd  xmm1, xmm3
1594:   mulpd  xmm0, xmm3
1612:   mulpd  xmm0, xmm5      ; <-- this is in the matmul inner loop
1614:   addpd  xmm1, xmm0      ; <--
```

(The first four are in `init_matrix`, also auto-vectorized; the last pair is the real matmul kernel.)

### 7.3 Compiler Explorer (godbolt.org) workflow

1. Go to https://godbolt.org/.
2. Paste your `matmul.cpp` in the left pane.
3. Top of right pane: select compiler **x86-64 gcc 13.3** (or whatever you used).
4. In the compiler-options box: `-std=c++17 -O2 -masm=intel`.
5. Add a second compiler pane (the **+ Add new...** button → **Compiler**) and put `-O3` in it, then a third with `-O3 -march=skylake`.
6. The right panes show color-coded assembly. Click on a C++ line to highlight the assembly it produced.

This is *the* tool for explaining the project visually to the professor — much more compelling than static screenshots.

### 7.4 Auto-vectorization in detail

GCC's loop vectorizer asks, for each loop:

1. Are the iterations independent? (no loop-carried dependencies it can't break)
2. Are the access patterns regular? (constant-stride loads/stores)
3. Do the trip counts allow a clean vectorization, or do we need a scalar epilogue?
4. Is the cost model favorable? (estimated SIMD throughput beats scalar)

Our k-loop has **one** loop-carried dependency: the running `sum`. But the vectorizer recognizes this as a *reduction* — a dependency where the only operation is associative-ish — and breaks it by keeping a SIMD-wide partial-sum vector and reducing it once at the very end. This is precisely what we see in the assembly.

You can ask the compiler to explain its decisions with `-fopt-info-vec-all`:

```bash
g++ -std=c++17 -O3 -fopt-info-vec-all -c matmul.cpp 2>&1 | grep -i matmul
```

It will report things like "loop vectorized using 16-byte vectors" (= SSE2, 2 doubles) or "loop vectorized using 32-byte vectors" (= AVX, 4 doubles) when you add `-march=native`.

### 7.5 Why matmul benefits so much from optimization

Three independent reasons compound:

1. **Trivially parallel inner work.** Each `A[i,k] * B[k,j]` multiplication is independent of every other — perfect for SIMD.
2. **Tight reuse pattern.** The same `A[i,k]` is used N times (once per j); the compiler doesn't have to load it from memory N times — once per k is enough, and SIMD makes that one load even cheaper per element produced.
3. **Predictable everything.** Loop bounds, strides, and address arithmetic are all compile-time-known constants. The optimizer has total information.

### 7.6 Branch prediction — brief note

A modern CPU keeps a Branch Target Buffer that learns the pattern of every branch. For a loop like `for (int k = 0; k < 1024; ++k)`, the back-edge `jne .L17` is taken 1023 times, then not taken once. After the first ~10 iterations, the predictor reaches 100% accuracy on this branch and the misprediction cost goes to zero. **Branch prediction is essentially free for our kernel** — every one of the three loops is a regular count-up. This is one reason matmul is a *good* benchmark: it isolates compute and memory effects without being polluted by branch mispredict noise.

### 7.7 The cache hierarchy and why our access pattern hurts

A typical x86-64 CPU has:

- **L1d** ~32–48 KB per core, ~4 cycles latency, 64-byte lines.
- **L2** ~256–1024 KB per core, ~12 cycles.
- **L3** several MB shared, ~40 cycles.
- **DRAM**, ~200+ cycles.

Each matrix is 8 MB — bigger than L2 on most desktop chips. When we stride down a column of B with 8 KB stride:

- The 64-byte line containing `B[k,j]` is fetched, but only `B[k,j]` itself (8 of those 64 bytes) is used before we jump 8 KB away.
- 1024 of these "single-use" lines accumulate per i,j-output cell.
- Even at 1024 cells × 1024 = ~1M lines per outer iteration, the 32 KB L1 holds maybe 500 lines — so we evict and re-fetch constantly.

This is why the speedup from `-O2` to `-O3 -march=native` is "only" 1.88× rather than the theoretical 2× from doubling the SIMD width: the extra arithmetic throughput buys us less than expected once memory becomes the binding resource. **A cache-blocked or `ikj`-reordered version would benefit much more from AVX**, because B's accesses would then be sequential.

---

## Files in the project directory

| File | What it is |
|---|---|
| `matmul.cpp` | The C++17 source. |
| `matmul_O0.s` / `matmul_O1.s` / `matmul_O2.s` / `matmul_O3.s` | Intel-syntax assembly at each level. |
| `matmul_O3_native.s` | Assembly with AVX (`-march=native`) — for the bonus comparison. |
| (this report) | The teaching/report write-up. |

Re-build everything with:

```bash
g++ -std=c++17 -O0 -S -masm=intel -fverbose-asm matmul.cpp -o matmul_O0.s
g++ -std=c++17 -O1 -S -masm=intel -fverbose-asm matmul.cpp -o matmul_O1.s
g++ -std=c++17 -O2 -S -masm=intel -fverbose-asm matmul.cpp -o matmul_O2.s
g++ -std=c++17 -O3 -S -masm=intel -fverbose-asm matmul.cpp -o matmul_O3.s
g++ -std=c++17 -O3 -march=native -S -masm=intel -fverbose-asm matmul.cpp -o matmul_O3_native.s

g++ -std=c++17 -O0 matmul.cpp -o matmul_O0
g++ -std=c++17 -O1 matmul.cpp -o matmul_O1
g++ -std=c++17 -O2 matmul.cpp -o matmul_O2
g++ -std=c++17 -O3 matmul.cpp -o matmul_O3
g++ -std=c++17 -O3 -march=native matmul.cpp -o matmul_O3_native
```

And re-benchmark with:

```bash
for b in matmul_O0 matmul_O1 matmul_O2 matmul_O3 matmul_O3_native; do
    echo "--- $b ---"; ./$b
done
```
