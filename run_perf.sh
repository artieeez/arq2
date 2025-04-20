#!/bin/bash

set -e

BINS=("quicksort" "matrix_mul" "dfs")
OUT_DIR="out"
RESULTS_DIR="results"

mkdir -p "$RESULTS_DIR"

for BIN in "${BINS[@]}"; do
  echo "Running perf for $BIN..."

  BIN_PATH="$OUT_DIR/$BIN"
  CSV_FILE="$RESULTS_DIR/${BIN}.csv"

  if [ ! -x "$BIN_PATH" ]; then
    echo "❌ Error: '$BIN_PATH' not found or not executable"
    continue
  fi

  # Write header if file does not exist
  if [ ! -f "$CSV_FILE" ]; then
    echo "timestamp,instructions,cycles,L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses,dTLB-loads,dTLB-load-misses" > "$CSV_FILE"
  fi

  # Run perf and capture values only
  PERF_OUTPUT=$(perf stat -x, -e instructions,cycles,L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses,dTLB-loads,dTLB-load-misses "$BIN_PATH" 2>&1)

  VALUES=$(echo "$PERF_OUTPUT" | awk -F',' 'NF>=3 { gsub(/[ \t]/, "", $1); print $1 }' | paste -sd "," -)

  echo "$(date -Iseconds),$VALUES" >> "$CSV_FILE"
done

echo "✅ Individual CSV files saved to '$RESULTS_DIR/'"
