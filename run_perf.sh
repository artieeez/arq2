#!/bin/bash

set -e

# Default to 1 run if not specified
RUNS=${1:-1}

BINS=("quicksort" "matrix_mul" "dfs")
OUT_DIR="out"
RESULTS_DIR="results"

mkdir -p "$RESULTS_DIR"

for BIN in "${BINS[@]}"; do
  BIN_PATH="$OUT_DIR/$BIN"
  CSV_FILE="$RESULTS_DIR/${BIN}.csv"

  if [ ! -x "$BIN_PATH" ]; then
    echo "❌ Error: '$BIN_PATH' not found or not executable"
    continue
  fi

  echo "Running perf for $BIN - $RUNS time(s)..."

  # Write header if the CSV does not exist
  if [ ! -f "$CSV_FILE" ]; then
    echo "timestamp,instructions,cycles,L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses,dTLB-loads,dTLB-load-misses" > "$CSV_FILE"
  fi

  for ((i = 1; i <= RUNS; i++)); do
    echo " → Run $i"

    PERF_OUTPUT=$(perf stat -x, -e instructions,cycles,L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses,dTLB-loads,dTLB-load-misses "$BIN_PATH" 2>&1)

    VALUES=$(echo "$PERF_OUTPUT" | awk -F',' 'NF>=3 { gsub(/[ \t]/, "", $1); print $1 }' | paste -sd "," -)

    echo "$(date -Iseconds),$VALUES" >> "$CSV_FILE"
  done
done

echo "✅ All results saved to '$RESULTS_DIR/'"
