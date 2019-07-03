#include <stdio.h>

int main(void) {
	int int1, int2, sum;

	puts("Enter first integer:");
	scanf("%d", &int1); // scanf takes in user input

	puts("Enter second integer");
	scanf("%d", &int2);

	sum = int1 + int2;

	printf("Sum is %d\n", sum);
} // end main
