#!/usr/bin/env bash
set -euo pipefail

# Member 4 — Benchmarking & Debugging Analyst
# Builds every optimization version, runs each one 5 times, and saves results.

CXX=${CXX:-g++}
SRC=matmul.cpp
RUNS=5

$CXX -std=c++17 -O0 "$SRC" -o matmul_O0
$CXX -std=c++17 -O1 "$SRC" -o matmul_O1
$CXX -std=c++17 -O2 "$SRC" -o matmul_O2
$CXX -std=c++17 -O3 "$SRC" -o matmul_O3
$CXX -std=c++17 -O3 -march=native "$SRC" -o matmul_O3_native

printf 'binary,run,time_s,gflops,checksum\n' > benchmark_results.csv

for binary in matmul_O0 matmul_O1 matmul_O2 matmul_O3 matmul_O3_native; do
  for run in $(seq 1 "$RUNS"); do
    echo "Running $binary: run $run/$RUNS" >&2
    output=$(./"$binary")
    time_s=$(echo "$output" | awk '/Time:/ {print $2}')
    gflops=$(echo "$output" | awk '/GFLOPS:/ {print $2}')
    checksum=$(echo "$output" | awk '/Checksum:/ {print $2}')
    printf '%s,%s,%s,%s,%s\n' "$binary" "$run" "$time_s" "$gflops" "$checksum" >> benchmark_results.csv
  done
done

python3 analyze_benchmark.py
