# Expansion

## File Exploration

Can use echo to search for files using expansion:

`echo *` is essentially the same thing as `ls` since `*` is a wilcard that expands into filenames. This can be drawn out into more complex regexes:

```sh
# paths starting with t
echo t*

# paths ending with s
echo *s

# paths staring with an uppercase letter
echo [[:upper:]]*

# directories in "example" with a "foobar" subdirectory
echo example/*/foobar
```

## Math

Mathematical equations can also be expanded, when matching the format `$((expression))`:

```sh
# prints "I have 24 dollars"
echo I have $(((5**2) - 1)) dollars
```

## Brace Expansion

Generates strings based on braced templates:

```sh
# prints file_0.md, file_1.md ... file_5.md
echo file_{0...5}.md

# created directories dir_a, dir_b
mkdir dir_{a,b}

# print letters from B to R
echo {B..R}

# braces can be nested (hello_world_1 ... hello_universe_3)
echo hello_{world_{1,2},universe_{2,3}}
```

## Command Substitution

Allows for the output of a command to be used as an expression:

```sh
# lists the files in the directory of the cp command
ls -l $(which cp)
```

## Quotes

Word-splitting is suppressed and the embedded spaces are not treated as delimiters, rather they become part of the argument when not using quotes.

```sh
echo $(cal)
# Output has no newlines or formatting), because all newlines/spaces are seen
# as separating arguments:
# July 2017 Su Mo Tu We Th Fr Sa 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

# note expansion still works within double quotes ($(), not something like *)
echo "$(cal)"
# Output, with newlines and spacing treated correctly:
# July 2017
# Su Mo Tu We Th Fr Sa
#                    1
#  2  3  4  5  6  7  8
#  9 10 11 12 13 14 15
# 16 17 18 19 20 21 22
# 23 24 25 26 27 28 29
# 30 31
```

**NOTE THAT EXPANSION IS SUPPRESSED WHEN USING SINGLE QUOTES**
