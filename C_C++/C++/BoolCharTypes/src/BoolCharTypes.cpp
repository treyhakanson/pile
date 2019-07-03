#include <iostream>

using namespace std;

int main() {

	bool a = true; // will also take 1
	bool b = false; // will also take 0

	// prints 1 and 0
	cout << "true: " << a << " || " << "false: " << b << endl;

	char c = 'A'; // can take a literal
	char d = 65; // or the ASCII character code

	cout << c << " || " << d << endl;

	// can cast as an int to see the ASCII code
	cout << (int) c << " || " << (int) d << endl;

	cout << "Size of char: " << sizeof(char) << endl;

	// wchar_t can represent a greater range of characters
	wchar_t e = 'i';
	cout << "Size of wchar_t: " << sizeof(wchar_t) << endl;

	return 0;
}
