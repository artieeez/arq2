#include <iostream>
#include <vector>

int main() {
    const int N = 1024;
    std::vector<std::vector<float>> A(N, std::vector<float>(N));
    std::vector<std::vector<float>> B(N, std::vector<float>(N));
    std::vector<std::vector<float>> C(N, std::vector<float>(N, 0));

    // Init A and B
    for (int i = 0; i < N; ++i)
        for (int j = 0; j < N; ++j) {
            A[i][j] = 1.0f;
            B[i][j] = 1.0f;
        }

    // Reordered loop: i, j, k
    for (int i = 0; i < N; ++i)
        for (int j = 0; j < N; ++j)
            for (int k = 0; k < N; ++k)
                C[i][j] += A[i][k] * B[k][j];

    std::cout << "Done\n";
}
