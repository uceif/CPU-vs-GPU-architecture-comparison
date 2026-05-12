// matmul.cpp
// Sequential 1024x1024 matrix multiplication benchmark
// Computer Architecture project — CPU & Assembly Developer part
//
// Build:
//   g++ -std=c++17 -O0 matmul.cpp -o matmul_O0
//   g++ -std=c++17 -O1 matmul.cpp -o matmul_O1
//   g++ -std=c++17 -O2 matmul.cpp -o matmul_O2
//   g++ -std=c++17 -O3 matmul.cpp -o matmul_O3

#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>

// Matrix dimension. Using a compile-time constant so the compiler can
// reason about loop bounds (important for optimization at -O2/-O3).
constexpr int N = 1024;

// We use a flat std::vector<double> of size N*N and index it manually
// as A[i*N + j]. This is "row-major" layout: row i is stored contiguously,
// then row i+1, etc. Row-major matches how C/C++ stores 2D arrays natively
// and is friendly to the CPU cache when we walk along a row.
using Matrix = std::vector<double>;

// Fill a matrix with deterministic values so every run produces the same
// result. Using a deterministic pattern (instead of rand()) means the
// checksum at the end is reproducible and we can verify correctness.
static void init_matrix(Matrix& M, int seed) {
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            // Simple deterministic pattern. The cast to double prevents
            // integer overflow and gives the compiler real FP work to do.
            M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
        }
    }
}

// The textbook triple-nested matrix multiplication: C = A * B
// For each output cell C[i][j], we compute the dot product of
// row i of A with column j of B.
//
// Loop order is i, j, k (the "ijk" order). This is the most natural
// reading of the math, but it is NOT the most cache-friendly — we will
// discuss this in the report. We deliberately keep the textbook form
// so the compiler has a clear pattern to optimize.
static void matmul(const Matrix& A, const Matrix& B, Matrix& C) {
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k) {
                // A[i][k] walks along a row of A (cache-friendly).
                // B[k][j] walks DOWN a column of B (cache-unfriendly:
                // each access jumps N*sizeof(double) = 8192 bytes).
                sum += A[i * N + k] * B[k * N + j];
            }
            C[i * N + j] = sum;
        }
    }
}

// Compute a checksum over C. We print it so the optimizer cannot delete
// the whole computation as "dead code". If C is never observed, an
// aggressive optimizer is allowed to remove the matmul entirely.
static double checksum(const Matrix& C) {
    double s = 0.0;
    for (int i = 0; i < N * N; ++i) s += C[i];
    return s;
}

int main() {
    std::cout << "Matrix multiplication " << N << " x " << N << "\n";
    std::cout << "Element type: double (8 bytes)\n";
    std::cout << "Memory per matrix: "
              << (static_cast<double>(N) * N * sizeof(double)) / (1024.0 * 1024.0)
              << " MB\n\n";

    // Allocate three NxN matrices on the heap (std::vector storage).
    // Stack would overflow: 1024*1024*8 bytes = 8 MB per matrix.
    Matrix A(N * N), B(N * N), C(N * N, 0.0);

    init_matrix(A, 1);
    init_matrix(B, 2);

    // High-resolution clock for benchmarking. steady_clock guarantees
    // monotonic time (it never goes backwards), which is what we want
    // for measuring elapsed wall-clock time.
    auto t0 = std::chrono::steady_clock::now();
    matmul(A, B, C);
    auto t1 = std::chrono::steady_clock::now();

    double seconds = std::chrono::duration<double>(t1 - t0).count();

    // GFLOPS = billions of floating-point operations per second.
    // Each output element does N multiplies + N adds = 2N FLOPs,
    // and there are N*N output elements, so total = 2*N^3 FLOPs.
    double gflops = (2.0 * N * N * N) / (seconds * 1e9);

    std::cout << std::fixed << std::setprecision(4);
    std::cout << "Time:     " << seconds << " s\n";
    std::cout << "GFLOPS:   " << gflops << "\n";
    std::cout << "Checksum: " << checksum(C) << "\n";
    return 0;
}
