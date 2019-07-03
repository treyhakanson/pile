#include <stdio.h>
#include <string.h>

int main(void) {
	// the * specifies a char array (a string)
	char *str1;
	char *str2;

	str1 = "Hello";
	str2 = "World";

	printf("%s, %s!\n", str1, str2);
	// strlen calculates the length of a string (unsigned long)
	printf("str1 length: %lu\n", strlen(str1));

	/* printf formats:
	 * %d - integer
	 * %u - unsigned integer
	 * %s - string or char
	 * %ld - signed long
	 * %lu - unsigned long
	 *
	 * see all formats for printf and scanf
	 * in Fig. 5.5 on page 168
	 */

} // end main
