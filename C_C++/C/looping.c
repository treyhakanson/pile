#include <stdio.h>

// see exercise 4.16 on page 153
int main(void) {
	// (A)
	int i, j;
	int max;

	max = 10;

	// (A)
	printf("(A)\n");
	printf("----------\n");
	for (i = 1; i < max; i++) {
		for (j = 0; j < i; j++)
			printf("%s", "*");
		printf("\n");
	}

	printf("\n\n");

	// (B)
	printf("(B)\n");
	printf("----------\n");
	for (i = max; i > 0; i--) {
		for (j = i; j > 0; j--)
			printf("%s", "*");
		printf("\n");
	}

	printf("\n\n");

	// (C)
	printf("(C)\n");
	printf("----------\n");
	for (i = 0; i < max; i++) {
		for (j = 0; j < i; j++)
			printf("%s", " ");
		for (; j < max; j++)
			printf("%s", "*");
		printf("\n");
	}

	// (D)
	printf("(D)\n");
	printf("----------\n");
	for (i = 0; i < max; i++) {
		for (j = 0; j < max - i; j++)
			printf("%s", " ");
		for (; j < max; j++)
			printf("%s", "*");
		printf("\n");
	}
} // end main
