#include <stdio.h>

int main(void) {
	int total;
	int count;

	float avg1;
	float avg2;

	total = 100;
	count = 6;

	// truncates to 16.00
	avg1 = total / count;
	printf("avg1 (no casting): %.2f\n", avg1);
	
	// casting; will not truncate
	avg2 = (float) total / count;
	printf("avg2 (cast to float) %.2f\n", avg2);

} // end main
