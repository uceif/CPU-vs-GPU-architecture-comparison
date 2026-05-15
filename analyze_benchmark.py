#!/usr/bin/env python3
import csv
from collections import defaultdict

rows = []
with open('benchmark_results.csv', newline='') as f:
    reader = csv.DictReader(f)
    for row in reader:
        row['time_s'] = float(row['time_s'])
        row['gflops'] = float(row['gflops'])
        rows.append(row)

order = ['matmul_O0', 'matmul_O1', 'matmul_O2', 'matmul_O3', 'matmul_O3_native']
groups = defaultdict(list)
for row in rows:
    groups[row['binary']].append(row)

baseline = sum(r['time_s'] for r in groups['matmul_O0']) / len(groups['matmul_O0'])

with open('benchmark_summary.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['binary', 'avg_time_s', 'min_time_s', 'max_time_s', 'avg_gflops', 'checksum', 'speedup_vs_O0'])
    for binary in order:
        data = groups[binary]
        avg_time = sum(r['time_s'] for r in data) / len(data)
        min_time = min(r['time_s'] for r in data)
        max_time = max(r['time_s'] for r in data)
        avg_gflops = sum(r['gflops'] for r in data) / len(data)
        checksum = data[0]['checksum']
        speedup = baseline / avg_time
        writer.writerow([binary, f'{avg_time:.4f}', f'{min_time:.4f}', f'{max_time:.4f}', f'{avg_gflops:.4f}', checksum, f'{speedup:.2f}'])

print('Benchmark summary written to benchmark_summary.csv')
