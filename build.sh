#!/bin/bash

set -e  # Exit if any command fails

echo "Compiling quicksort..."
g++ -O2 -g ./bin/quicksort.cpp -o ./out/quicksort

echo "Compiling matrix_mul..."
g++ -O2 -g ./bin/matrix_mul.cpp -o ./out/matrix_mul

echo "Compiling dfs..."
g++ -O2 -g ./bin/dfs.cpp -o ./out/dfs

echo "✅ All programs compiled successfully."
