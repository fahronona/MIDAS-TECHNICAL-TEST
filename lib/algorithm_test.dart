int candies(int n, List<int> arr) {
  List<int> candies = List<int>.filled(n, 1);

  for (int i = 1; i < n; i++) {
    if (arr[i] > arr[i - 1]) {
      candies[i] = candies[i - 1] + 1;
    }
  }

  for (int i = n - 2; i >= 0; i--) {
    if (arr[i] > arr[i + 1] && candies[i] <= candies[i + 1]) {
      candies[i] = candies[i + 1] + 1;
    }
  }

  print(candies);
  int totalCandies = candies.reduce((a, b) => a + b);

  return totalCandies;
}

void main() {
  int n = 10;
  List<int> ratings = [2, 4, 2, 6, 1, 7, 8, 9, 2, 1];
  int result = candies(n, ratings);
  print(result);
}
