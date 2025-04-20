#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

void quicksort(std::vector<int>& arr, int left, int right) {
    int i = left, j = right;
    int pivot = arr[(left + right) / 2];
    while (i <= j) {
        while (arr[i] < pivot) ++i;
        while (arr[j] > pivot) --j;
        if (i <= j) {
            std::swap(arr[i], arr[j]);
            ++i; --j;
        }
    }
    if (left < j) quicksort(arr, left, j);
    if (i < right) quicksort(arr, i, right);
}

int main() {
    const int size = 1 << 20;
    std::vector<int> data(size);
    std::srand(std::time(nullptr));
    for (int& x : data) x = std::rand();
    quicksort(data, 0, size - 1);
    std::cout << "Done\n";
}
