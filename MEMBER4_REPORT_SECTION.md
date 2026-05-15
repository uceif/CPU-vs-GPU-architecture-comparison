## Member 4 — Benchmarking and Debugging Analysis

### Benchmarking methodology

For the benchmarking part, I tested the same `matmul.cpp` program under five compiler configurations:

- `-O0`
- `-O1`
- `-O2`
- `-O3`
- `-O3 -march=native`

Each executable was run **five times**. For every run, I recorded the execution time, GFLOPS, and checksum. The average execution time was then calculated using:

\[
Average\ Time = \frac{Run_1 + Run_2 + Run_3 + Run_4 + Run_5}{5}
\]

Speedup was calculated relative to the unoptimized baseline `-O0`:

\[
Speedup = \frac{Average\ Time\ of\ O0}{Average\ Time\ of\ Optimized\ Version}
\]

The benchmark uses `std::chrono::steady_clock`, which is appropriate for measuring elapsed execution time because it is monotonic and does not go backwards during execution.

### Benchmark results

| Optimization level | Run 1 (s) | Run 2 (s) | Run 3 (s) | Run 4 (s) | Run 5 (s) | Average (s) | Average GFLOPS | Speedup vs `-O0` | Checksum |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| `-O0` | 6.0518 | 6.3118 | 6.2986 | 5.7911 | 6.8526 | 6.2612 | 0.3440 | 1.00x | 657440507200.0000 |
| `-O1` | 4.0722 | 4.0418 | 4.0679 | 2.8773 | 4.0691 | 3.8257 | 0.5721 | 1.64x | 657440507200.0000 |
| `-O2` | 1.9638 | 2.0338 | 2.0985 | 2.0909 | 1.8610 | 2.0096 | 1.0707 | 3.12x | 657440507200.0000 |
| `-O3` | 2.0647 | 2.1251 | 2.0587 | 2.0923 | 2.0946 | 2.0871 | 1.0291 | 3.00x | 657440507200.0000 |
| `-O3 -march=native` | 1.0123 | 1.0478 | 1.1049 | 1.0307 | 1.0819 | 1.0555 | 2.0366 | 5.93x | 657440507200.0000 |

### Correctness verification

All optimization levels produced the same checksum:

\[
657440507200.0000
\]

This confirms that the compiler optimizations improved performance without changing the mathematical result. The checksum is important because it prevents the compiler from treating the matrix multiplication as dead code. Since the result is printed and observed, the compiler must actually execute the calculation.

### Performance analysis

The unoptimized `-O0` version is the slowest, with an average time of **6.2612 seconds**. This is expected because `-O0` keeps variables mostly in memory, avoids aggressive instruction optimization, and does not perform SIMD vectorization.

The `-O1` version improves performance to **3.8257 seconds**, giving a **1.64x speedup** over `-O0`. This improvement mainly comes from reducing unnecessary memory accesses, using CPU registers more effectively, inlining simple operations, and simplifying loop overhead.

The `-O2` version gives a much larger improvement, reducing the average time to **2.0096 seconds** and achieving a **3.12x speedup**. This is where auto-vectorization becomes important. The compiler can use SIMD instructions to process more than one double value per instruction, which significantly improves throughput.

The `-O3` version averaged **2.0871 seconds**, which is very close to `-O2`. In this test, `-O3` did not provide a major improvement over `-O2`. This is an important result because it shows that `-O3` is not always faster. Once the main loop is already vectorized and optimized, the remaining bottleneck is memory access, especially the cache-unfriendly access pattern when reading matrix `B` column-wise.

The fastest version was `-O3 -march=native`, with an average time of **1.0555 seconds** and a **5.93x speedup** over `-O0`. This version allows the compiler to use instructions supported by the specific CPU, such as wider SIMD instructions. Because of that, it can process more data per instruction than the default portable build.

### Amdahl's Law connection

Amdahl's Law explains why speedup has a limit. Even when the most expensive part of the program is optimized, the total speedup is limited by the parts that cannot be improved and by hardware bottlenecks such as memory access.

\[
Speedup = \frac{1}{(1-P)+\frac{P}{N}}
\]

Where:

- `P` is the portion of the program that can be improved or parallelized.
- `N` is the improvement factor or number of parallel units.

In this project, the matrix multiplication loop is highly optimizable, but not everything can be sped up infinitely. Memory access, cache misses, loop overhead, initialization, and checksum calculation still take time. This is why the optimized versions are much faster than `-O0`, but the speedup does not grow without limit.

### Debugging conclusion

The benchmark results are valid because every version produced the same checksum. This means there was no correctness bug caused by optimization. The performance results also follow a logical pattern: higher optimization levels generally reduce execution time, while `-O3 -march=native` gives the best result because it uses CPU-specific instructions.

Overall, the best-performing configuration is:

\[
\texttt{-O3 -march=native}
\]

It achieved the lowest average execution time, the highest GFLOPS, and the highest speedup while preserving the correct output.
