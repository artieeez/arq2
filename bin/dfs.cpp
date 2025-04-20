#include <iostream>
#include <vector>
#include <cstdlib>

void dfs(int u, const std::vector<std::vector<int>>& adj, std::vector<bool>& visited) {
    visited[u] = true;
    for (int v : adj[u])
        if (!visited[v])
            dfs(v, adj, visited);
}

int main() {
    const int N = 100000;
    std::vector<std::vector<int>> adj(N);

    // Randomly connect nodes
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < 5; ++j) {
            int neighbor = std::rand() % N;
            adj[i].push_back(neighbor);
        }
    }

    std::vector<bool> visited(N, false);
    dfs(0, adj, visited);
    std::cout << "Done\n";
}
