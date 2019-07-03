// this doesn't end in a semicolon because it isn't a C++ statement; it's for the
// preprocessor
#include <iostream>

// this is a method prototype; method's aren't hoisted in C++, so if you want to call
// a method before it's defined, a prototype is required
//void doSomething();

// can define this separately in a .h file; it's convention to import local includes with ""
// and standard includes with <>
// this will literally include the contents of utils.h here; the preprocessor does this
#include "utils.h"

using namespace std;

// doesn't need a prototype because its fully defined before being invoked in the main
// function
void doAnotherThing() {
	cout << "This works too!" << endl;
}

int main() {
	doSomething();
	doAnotherThing();

	return 0;
}

// this is ok because of the included prototype
void doSomething() {
	cout << "It works!" << endl;
}
