#include <iostream>

using namespace std;

int median(int a[], int i, int j) {
   int n = j - i;

   if (n % 2 == 0) {
      return (a[n / 2 + i - 1] + a [n / 2 + i]) / 2;
   } else {
      return a[n / 2 + i];
   }
}

int main() {
   int n = 20, q1, q2, q3;
   int a[] = { 6, 6, 6, 6, 6, 8, 8, 8, 10, 10, 12, 12, 12, 12, 16, 16, 16, 16, 16, 20 };

   q1 = median(a, 0, n / 2);
   q2 = median(a, 0, n);

   if (n % 2 == 0) {
      q3 = median(a, n / 2, n);
   } else {
      q3 = median(a, n / 2 + 1, n);
   }

   cout << q1 << endl << q2 << endl << q3 << endl << q3 - q1 << endl;
}
