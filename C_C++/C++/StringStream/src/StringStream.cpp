#include <iostream>
#include <sstream>

using namespace std;

int main() {
	string name = "Trey Hakanson";
	int age = 22;

	// can't concat strings and other types like int using +;
	// so use string streams instead
	stringstream ss;

	// works similarly to cout
	ss << "Age is: ";
	ss << age;
	ss << "; Name is: ";
	ss << name;

	// convert stream to a string
	string info = ss.str();

	cout << "Info" << endl;
	cout << "==================================" << endl;
	cout << info << endl;

	return 0;
}
