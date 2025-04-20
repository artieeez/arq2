#!/bin/bash

set -e

BINS=("quicksort" "matrix_mul" "dfs")
OUT_DIR="out"
RESULTS_DIR="results"

mkdir -p "$RESULTS_DIR"

for BIN in "${BINS[@]}"; do
  echo "Running perf for $BIN..."

  CSV_FILE="$RESULTS_DIR/${BIN}.csv"
  BIN_PATH="$OUT_DIR/$BIN"

  if [ ! -x "$BIN_PATH" ]; then
    echo "❌ Error: '$BIN_PATH' not found or not executable"
    continue
  fi

  # Header
  echo "Metric,Value,Unit" > "$CSV_FILE"

  # Run perf and collect results
  perf stat -x, -e instructions,cycles,L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses,dTLB-loads,dTLB-load-misses "$BIN_PATH" 2>&1 \
    | awk -F',' 'NF>=3 { gsub(/^[ \t]+|[ \t]+$/, "", $1); gsub(/^[ \t]+|[ \t]+$/, "", $2); gsub(/^[ \t]+|[ \t]+$/, "", $3); print $2 "," $1 "," $3 }' \
    >> "$CSV_FILE"
done

echo "✅ All perf results saved in the '$RESULTS_DIR' folder."
