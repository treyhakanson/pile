#include <iostream> // used for io
#include <limits> // contains the max values of various types

using namespace std;

int main() {
	// standard int
	int value = 342123;
	cout << "Max integer value: " << INT_MAX << endl;
	cout << "Min integer value: " << INT_MIN << endl;

	// bigger than an int, takes up more space (`int` can be dropped)
	long int a = 2094809321;
	cout << "Max long integer value: " << LONG_MAX << endl;
	cout << "Min long integer value: " << LONG_MIN << endl;

	// smaller than an int, takes up less space (`int` can be dropped)
	short int b = 213;
	cout << "Max short integer value: " << SHRT_MAX << endl;
	cout << "Min short integer value: " << SHRT_MIN << endl;

	cout << "----------------------------------" << endl;

	// size comparisons (`sizeOf` returns bytes)
	cout << "Size of short int: " << sizeof(short int) << endl;
	cout << "Size of int: " << sizeof(int) << endl;
	cout << "Size of long int: " << sizeof(long int) << endl;
	cout << "Size of unsigned int: " << sizeof(long int) << endl;

	// unsigned modifier is available as a modifier to use the sign bit
	// to expand the allowed integer size. Positive only.
	unsigned long int c = 82798123312; // takes up same amount of space as a long int

	return 0;
}
