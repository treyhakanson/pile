#include <iostream>

using namespace std;

string to_binary(int x) {
   string b = "";
   while (x > 0) {
      cout << x << endl;
      b = ((x % 2) ? "1" : "0") + b;
      x /= 2;
   }
   return b;
}

int main() {
   int n;

   while (true) {
      cout << "Number to convert: ";
      cin >> n;

      if (n < 0) break;
      
      cout << to_binary(n) << endl;
   }
}
