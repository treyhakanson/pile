#include <iostream>

using namespace std;

int main() {

	// initialize an array of 3 uninitialized values (will give garbage values
	// if attempted to access)
	int values[3];

	// can use an array literal to declare elements on initialization
	double values2[4] = { 1.2, 12.34, 4234.6, 5.4234 };

	// will initialize an array of all zeros
	int values3[5] = {};

	// if initializing with a literal, don't need to specify size
	char characters[] = { 'A', 'B', 'C' };

	// C will NOT stop you from accessing an out of bounds element; will simply give
	// you the next block of memory, whatever that is
	cout << "Out of bounds: " << values[10] << endl;

	// *IMPORTANT* can also write to an out of bounds value, which can be very dangerous

	// can also define multidimensional arrays (must define length of inner arrays)
	string animals[][3] = {
		{"dog", "cat", "pig"},
		{"fox", "cow", "mouse"},
		{"wombat", "frog", "chicken"}
	};

	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			cout << animals[i][j] << " "<< flush;
		}
		cout << endl;
	}

	// dynamically determining the length of an array
	int nums[] = { 1, 2, 3, 4 };

	cout << endl << "Size of Array: " << sizeof(nums) << endl;
	cout << "Size of elemnts: " << flush;

	for (int i = 0; i < 4; i++) {
		cout << sizeof(nums[i]) << " " << flush;
	}

	unsigned int lengthNums = sizeof(nums) / sizeof(int);
	cout << endl << "Length of Array: " << lengthNums << endl;

	// sizeof technically returns an unsigned int, so comparison in a for loop
	// needs to be between another unsigned int (will cast for you, but this is
	// more efficient):
	for (unsigned int i = 0; i < sizeof(nums) / sizeof(int); i++) {
		cout << nums[i] << " " << flush;
	}
	cout << endl << endl;

	// length of multidimensional array
	string words[][2][2] = {
			{
					{"foo", "bar"},
					{"big", "little"}
			},
			{
					{"hello", "world"},
					{"hey", "universe"}
			}
	};

	cout << "Multidimensional Array Looping" << endl;
	cout << "==============================" << endl;
	// could use 0 in place of i in words[i]
	for (unsigned int i = 0; i < sizeof(words) / sizeof(words[i]); i++) {
		cout << "words[" << i << "]" << endl;
		// could use 0 in place of j in words[i][j]
		for (unsigned int j = 0; j < sizeof(words[i]) / sizeof(words[i][j]); j++) {
			cout << '\t' << "words[" <<i << "][" << j << "]" << " " << endl;
			// could use string in place of words[i][j][k]
			for (unsigned int k = 0; k < sizeof(words[i][j]) / sizeof(words[i][j][k]); k++) {
				cout << '\t' << '\t' << "words[" << i << "][" << j << "][" << k << "] = " << words[i][j][k] << flush;
			}
			cout << endl;
		}
		cout << endl;
	}

	return 0;
}
