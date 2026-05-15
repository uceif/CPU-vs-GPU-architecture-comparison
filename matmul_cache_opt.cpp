// matmul_cache_opt.cpp
// Member 3 — Cache & Memory Optimizer
// Computer Architecture project: CPU vs GPU Architecture Comparison
//
// This file benchmarks FOUR versions of 1024×1024 matrix multiplication,
// each with a different memory access strategy. The goal is to measure
// the effect of cache friendliness on real performance.
//
// Versions:
//   1. ijk  — textbook order (from Member 1), column-strided B access (bad for cache)
//   2. ikj  — reordered loops, sequential access to both A and B (cache-friendly)
//   3. jki  — worst possible order (both strided accesses)
//   4. TILED — cache blocking (tile size 64), keeps working set in L1/L2
//
// Build:
//   g++ -std=c++17 -O2 matmul_cache_opt.cpp -o matmul_cache_opt
//
// Valgrind cache profiling (Linux/WSL):
//   valgrind --tool=cachegrind --cache-sim=yes ./matmul_cache_opt

#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>
#include <string>
#include <cmath>

constexpr int N     = 1024;
constexpr int TILE  = 64;   // tile size — tune so TILE*TILE*3*8 bytes fits in L1/L2
                             // 64*64*3*8 = 98 304 bytes ≈ 96 KB  (fits comfortably in L2)

using Matrix = std::vector<double>;

// ─────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────

static void init_matrix(Matrix& M, int seed) {
    for (int i = 0; i < N; ++i)
        for (int j = 0; j < N; ++j)
            M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
}

static void zero_matrix(Matrix& M) {
    for (auto& v : M) v = 0.0;
}

static double checksum(const Matrix& C) {
    double s = 0.0;
    for (int i = 0; i < N * N; ++i) s += C[i];
    return s;
}

// ─────────────────────────────────────────────────────────────
// Version 1 — ijk (textbook / Member 1 baseline)
//
// Cache behaviour:
//   A[i*N+k] : k increases by 1 → stride 1 → SEQUENTIAL  (good)
//   B[k*N+j] : k increases by 1 → stride N → COLUMN WALK (bad, ~100% L1 miss on B)
//   C[i*N+j] : written once per (i,j) pair             (neutral)
// ─────────────────────────────────────────────────────────────
static void matmul_ijk(const Matrix& A, const Matrix& B, Matrix& C) {
    for (int i = 0; i < N; ++i)
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k)
                sum += A[i * N + k] * B[k * N + j];
            C[i * N + j] = sum;
        }
}

// ─────────────────────────────────────────────────────────────
// Version 2 — ikj (cache-friendly reorder)
//
// Swap the j and k loops so the innermost loop varies j.
//
// Cache behaviour:
//   A[i*N+k] : fixed for the entire j-loop → loaded once, stays in register (perfect)
//   B[k*N+j] : j increases by 1 → stride 1 → SEQUENTIAL (good)
//   C[i*N+j] : j increases by 1 → stride 1 → SEQUENTIAL (good)
//
// This turns the column-walk of B into a row-walk. Both B and C
// are now fully sequential. A single scalar A[i,k] is broadcast
// (or kept in a register) across the entire inner loop.
// Expected speedup over ijk: 2–6× (hardware-dependent).
// ─────────────────────────────────────────────────────────────
static void matmul_ikj(const Matrix& A, const Matrix& B, Matrix& C) {
    for (int i = 0; i < N; ++i)
        for (int k = 0; k < N; ++k) {
            double a_ik = A[i * N + k];   // hoist A load outside j-loop
            for (int j = 0; j < N; ++j)
                C[i * N + j] += a_ik * B[k * N + j];
        }
}

// ─────────────────────────────────────────────────────────────
// Version 3 — jki (intentionally worst order, for contrast)
//
// Cache behaviour:
//   C[i*N+j] : i varies → stride N → COLUMN WALK (bad)
//   A[i*N+k] : i varies → stride N → COLUMN WALK (bad)
//   B[k*N+j] : fixed inside i-loop               (neutral)
//
// Both A and C are column-strided. This is the worst of the
// six possible loop orders for row-major storage.
// ─────────────────────────────────────────────────────────────
static void matmul_jki(const Matrix& A, const Matrix& B, Matrix& C) {
    for (int j = 0; j < N; ++j)
        for (int k = 0; k < N; ++k) {
            double b_kj = B[k * N + j];   // hoist B load
            for (int i = 0; i < N; ++i)
                C[i * N + j] += b_kj * A[i * N + k];
        }
}

// ─────────────────────────────────────────────────────────────
// Version 4 — Tiled / Cache-Blocked (TILE × TILE blocks)
//
// Instead of looping over entire rows/columns, we divide the
// matrices into TILE×TILE sub-matrices and process one tile
// at a time. Within each tile, the working set is:
//   3 tiles × TILE² × 8 bytes = 3 × 64² × 8 = 98 304 bytes ≈ 96 KB
// This fits in L2 (typically 256 KB – 1 MB) so the tile data
// stays warm in cache and is reused without re-fetching from RAM.
//
// Cache behaviour:
//   Within each tile, both A-tile (row-walk) and B-tile (row-walk
//   because the tile is small enough) are sequential.
//   C-tile accumulates in place — also sequential.
//
// This is the standard "cache oblivious / cache blocking" trick
// used by BLAS libraries and the compiler when it does tiling.
// ─────────────────────────────────────────────────────────────
static void matmul_tiled(const Matrix& A, const Matrix& B, Matrix& C) {
    for (int ii = 0; ii < N; ii += TILE)
        for (int jj = 0; jj < N; jj += TILE)
            for (int kk = 0; kk < N; kk += TILE)
                // process one TILE×TILE block of C
                for (int i = ii; i < ii + TILE; ++i)
                    for (int k = kk; k < kk + TILE; ++k) {
                        double a_ik = A[i * N + k];
                        for (int j = jj; j < jj + TILE; ++j)
                            C[i * N + j] += a_ik * B[k * N + j];
                    }
}

// ─────────────────────────────────────────────────────────────
// Timing helper
// ─────────────────────────────────────────────────────────────
struct Result {
    double seconds;
    double gflops;
    double chk;
};

template<typename Fn>
static Result bench(Fn fn, const Matrix& A, const Matrix& B, Matrix& C) {
    zero_matrix(C);
    auto t0 = std::chrono::steady_clock::now();
    fn(A, B, C);
    auto t1 = std::chrono::steady_clock::now();
    double s = std::chrono::duration<double>(t1 - t0).count();
    double gf = (2.0 * N * N * N) / (s * 1e9);
    return {s, gf, checksum(C)};
}

// ─────────────────────────────────────────────────────────────
// main
// ─────────────────────────────────────────────────────────────
int main() {
    std::cout << "=== Member 3: Cache & Memory Optimization ===\n";
    std::cout << "Matrix size : " << N << " x " << N << "\n";
    std::cout << "Tile size   : " << TILE << " x " << TILE << "\n";
    std::cout << "Working set per tile: "
              << (3.0 * TILE * TILE * sizeof(double)) / 1024.0
              << " KB\n\n";

    Matrix A(N * N), B(N * N), C(N * N, 0.0);
    init_matrix(A, 1);
    init_matrix(B, 2);

    // ── Run all four versions ──────────────────────────────────
    auto r_ijk   = bench(matmul_ijk,   A, B, C);
    auto r_ikj   = bench(matmul_ikj,   A, B, C);
    auto r_jki   = bench(matmul_jki,   A, B, C);
    auto r_tiled = bench(matmul_tiled, A, B, C);

    // ── Print results ──────────────────────────────────────────
    std::cout << std::fixed << std::setprecision(4);

    const std::string sep(58, '-');
    std::cout << sep << "\n";
    std::cout << std::left
              << std::setw(12) << "Version"
              << std::setw(10) << "Time(s)"
              << std::setw(12) << "GFLOPS"
              << std::setw(14) << "Checksum"
              << "Speedup vs ijk\n";
    std::cout << sep << "\n";

    auto row = [&](const std::string& name, const Result& r, double base) {
        std::cout << std::setw(12) << name
                  << std::setw(10) << r.seconds
                  << std::setw(12) << r.gflops
                  << std::setw(14) << r.chk
                  << std::setprecision(2) << (base / r.seconds) << "x\n"
                  << std::setprecision(4);
    };

    double base = r_ijk.seconds;
    row("ijk",   r_ijk,   base);
    row("ikj",   r_ikj,   base);
    row("jki",   r_jki,   base);
    row("tiled", r_tiled, base);
    std::cout << sep << "\n\n";

    // ── Correctness check ──────────────────────────────────────
    std::cout << "Correctness (all checksums must match):\n";
    bool ok = true;
    for (auto& [name, chk] : std::vector<std::pair<std::string,double>>{
            {"ikj",   r_ikj.chk},
            {"jki",   r_jki.chk},
            {"tiled", r_tiled.chk}})
    {
        bool match = std::fabs(chk - r_ijk.chk) < 1e-3;
        std::cout << "  " << name << " vs ijk: " << (match ? "MATCH" : "MISMATCH") << "\n";
        if (!match) ok = false;
    }
    std::cout << (ok ? "\nAll results correct.\n" : "\nWARNING: mismatch detected!\n");

    // ── Cache intuition summary ────────────────────────────────
    std::cout << "\n=== Cache Access Pattern Summary ===\n";
    std::cout << "Version  | A access  | B access  | C access  | Expected\n";
    std::cout << "---------|-----------|-----------|-----------|----------\n";
    std::cout << "ijk      | seq       | COL WALK  | seq       | slow (B misses)\n";
    std::cout << "ikj      | scalar    | seq       | seq       | fast\n";
    std::cout << "jki      | COL WALK  | scalar    | COL WALK  | very slow\n";
    std::cout << "tiled    | seq/tile  | seq/tile  | seq/tile  | fast + reuse\n";

    return 0;
}
