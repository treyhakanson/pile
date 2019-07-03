#include <stdio.h>

// declare the function prototype (argument names are optional
// in function prototypes)
// <return type> functionName(<arg type> argName)
int square(int);

// start main
/* 
	note that even "main" has a return type;
	this is used to determine whether or not
	a program completed successfully. C programs
	implicitly return 0 when compiled using a modern
	method, which means no error.
*/
int main(void) {
	int num, squared;

	num = 3;

	// invoke the function
	squared = square(num);

	printf("%d squared is %d\n", num, squared);
} // end main

// start square
// this is the actual code for the signature defined above
int square(int x) {
	return x * x;
} // end square
