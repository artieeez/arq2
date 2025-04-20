#include <iostream>
#include <vector>

int main() {
    const int N = 1024;
    std::vector<std::vector<float>> A(N, std::vector<float>(N));
    std::vector<std::vector<float>> B(N, std::vector<float>(N));
    std::vector<std::vector<float>> C(N, std::vector<float>(N));

    // Init A and B
    for (int i = 0; i < N; ++i)
        for (int j = 0; j < N; ++j)
            A[i][j] = B[i][j] = 1.0;

    // Multiply
    for (int i = 0; i < N; ++i)
        for (int k = 0; k < N; ++k)
            for (int j = 0; j < N; ++j)
                C[i][j] += A[i][k] * B[k][j];

    std::cout << "Done\n";
}
