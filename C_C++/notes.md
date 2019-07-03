# C/C++

## Overview

C/C++ have no layer between themselves and the machine; it's about as low-level as it gets

## Variables

`const` modifier can be used to create a constants

## Switch

- variables cannot be used in `case`s, but `const`s (constants) can be
- need break statements
- faster than if else when used properly

## Compilation

using gcc (on Mac OSX):
```sh
gcc file.c -o output
```

## Escape Characters

```c
"\n" // newline
"\t" // tab
"\a" // alert; makes a sound without moving the cursor
"\\" // a \ character
"\"" // a " character
```

## Miscellaneous

similar to js, no braces are needed it only one line after statement

`<limits.h>` contains constants for the maximum values able to be stored in given types, such as `INT_MAX` and `INT_MIN`

## Error Prevention Tips

don't start variable names with `_`

## Weird bits

if a `printf` statement does not end is a newline, use the 2 argument call for security reasons:
```c
// bad
printf("Welcome");

// good
printf("%s", "Welcome");
```

## Computer Memory

8 bits = 1 byte

overflow in C is odd; for example, if too large a number is attempted to be inserted in an integer, it will not give an error, but rather will just generate an essentially random number.
