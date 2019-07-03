#include <stdio.h>

int max_profit(int arr[], int n) {
   /*
    * Want to buy when the difference next_price - current_price > 0,
    * Want to sell when the difference next_price - current_price < 0
    */
   if (n < 2) return -1;

   int diff, buy_price = 0, profit = 0;

   for (int i = 0; i < n - 1; i++) {
      diff = arr[i + 1] - arr[i];

      if (!buy_price && diff > 0) {
         printf("BUYING AT DAY %d FOR %d\n", i, arr[i]);
         buy_price = arr[i];
      }

      if (buy_price && diff < 0) {
         printf("SELLING AT DAY %d FOR %d\n", i, arr[i]);
         profit += arr[i] - buy_price;
         buy_price = 0;
      }
   }

   if (buy_price) {
      printf("SELLING AT DAY %d FOR %d\n", n - 1, arr[n - 1]);
      profit += arr[n - 1] - buy_price;
   }

   return profit;
}

int main() {
   int arr[] = {100, 180, 260, 310, 40, 535, 695};
   int n = sizeof(arr) / sizeof(arr[0]);
   printf("TOTAL PROFIT: %d\n", max_profit(arr, n));
}
