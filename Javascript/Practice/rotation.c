#include <stdio.h>

////////////////////////////////////////////////////////////////////////////////

int equality(int x[], int y[], int x_n, int y_n) {
   if (x_n != y_n) return 0;
   for (int i = 0; i < x_n; i++) {
      if (x[i] != y[i]) return 0;
   }
   return 1;
}

void print_arr(int arr[], int n) {
   printf("< ");
   for (int i = 0; i < n; i++) {
      printf("%d ", arr[i]);
   }
   printf(">\n");
}

////////////////////////////////////////////////////////////////////////////////

void rotate_1(int arr[], int rp, int n) {
   int a[rp];
   for (int i = 0; i < rp; i++) {
      a[i] = arr[i];
   }
   for (int i = rp; i < n; i++) {
      arr[i - rp] = arr[i];
   }
   for (int i = n - rp; i < n; i++) {
      arr[i] = a[i - n + rp];
   }
}

////////////////////////////////////////////////////////////////////////////////

void shift_left_one(int arr[], int n) {
   int first = arr[0];
   for (int i = 1; i < n; i++) {
      arr[i - 1] = arr[i];
   }
   arr[n - 1] = first;
}

void rotate_2(int arr[], int rp, int n) {
   for (int i = 0; i < rp; i++) {
      shift_left_one(arr, n);
   }
}

////////////////////////////////////////////////////////////////////////////////

int find_pivot_1(int arr[], int n) {
   int prev = arr[0];
   for (int i = 1; i < n; i++) {
      if (arr[i] - prev < 0) return n - i;
      prev = arr[i];
   }
   return -1;
}

int find_pivot_2(int arr[], int i, int j) {
   if (j < i)  return -1;
   if (j == i) return i;

   int mid = (i + j) / 2;

   if (mid < j && arr[mid] > arr[mid + 1]) {
      return mid;
   }

   if (mid > i && arr[mid] < arr[mid - 1]) {
      return mid - 1;
   }

   if (arr[i] >= arr[mid]) {
      return find_pivot_2(arr, i, mid - 1);
   }

   return find_pivot_2(arr, mid + 1, j);
}

////////////////////////////////////////////////////////////////////////////////

int binary_search(int arr[], int x, int i, int j) {
   if (j < i) return -1;

   int mid = (j + i) / 2;

   if (arr[mid] < x) {
      return binary_search(arr, x, mid + 1, j);
   }

   if (arr[mid] > x) {
      return binary_search(arr, x, i, mid - 1);
   }

   return mid;
}

int find_pivoted_element(int arr[], int x, int n) {
   int pivot = find_pivot_2(arr, 0, n - 1);

   if (pivot == -1) { // not rotated
      return binary_search(arr, x, 0, n - 1);
   }

   if (arr[0] <= x) {
      return binary_search(arr, x, 0, pivot);
   }

   return binary_search(arr, x, pivot + 1, n - 1);
}

////////////////////////////////////////////////////////////////////////////////

int main() {
   int x[] = { 4, 5, 6, 7, 1, 2, 3 };
   printf("Element Index: %d\n", find_pivoted_element(x, 2, 7));
   printf("Element Index: %d\n", find_pivoted_element(x, 3, 7));
   printf("Element Index: %d\n", find_pivoted_element(x, 4, 7));
   printf("Element Index: %d\n", find_pivoted_element(x, 5, 7));
}
