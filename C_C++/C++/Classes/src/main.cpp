#include <iostream>

#include "Animal.h"

using namespace std;

int main() {

	cout << "Program started" << endl;

	// surrounding code with curly braces will force their memory to be deallocated upon
	// hitting the closing bracket (scoping)
	{
		Animal peter("Peter");
		peter.speak();

		// `&charles` is equal to the value of `this` in the constructor
		Animal charles("Charles");
		charles.setHappiness(false);
		charles.speak();
	}

	cout << "Program ended" << endl;

	return 0;
}
