#include <iostream>
#include <iomanip> // io manipulation

using namespace std;

int main() {

	// floats are as expected, they allow decimals
	// floats are not exact; you only get about 5 decimals of precision before
	// some garbage
	float a = 2312.23473298;

	// `setprecision`, `fixed`, and `scientific` are all from `iomnaip`
 	cout << setprecision(20) << fixed << a << endl;
	cout << scientific << a << endl;

	// double gets a much higher precision, but still has some garbage
	double b = 2312.23473298;

	cout << setprecision(20) << fixed << b << endl;
	cout << scientific << b << endl;

	// `long double` has even greater precision

	// size comparison
	cout << "Size of float: " << sizeof(float) << endl;
	cout << "Size of double: " << sizeof(double) << endl;
	cout << "Size of long double: " << sizeof(long double) << endl;

	return 0;
}
