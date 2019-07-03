# Filters

Some common filters that can be used to process standard input. Particularly useful when used in unison with the `|` operator

## Filter Overview

| Filter | Description                                                        |
|:-------|:-------------------------------------------------------------------|
| sort   | sorts                                                              |
| uniq   | removes duplicate lines of data                                    |
| grep   | returns lines that match an expression                             |
| fmt    | formats text                                                       |
| pr     | splits data into pages with page breaks, headers and footers       |
| head   | outputs the first few lines of the input                           |
| tail   | outputs the last few lines of the input                            |
| tr     | translates characters                                              |
| sed    | stream editor, can perform more sophisticated translations that tr |
| awk    | a program for constructing filters                                 |

## Indepth Information

### sort

| Flag    | Description                                              |
|:--------|:---------------------------------------------------------|
| -b      | ignore leading blanks                                    |
| -d      | dictionary order                                         |
| -f      | ignore case; folds lowercase to uppercase                |
| -g      | compare according to general numeric value               |
| -i      | consider only printable characters                       |
| -M      | month sort                                               |
| -n      | compare according to string numerical value              |
| -r      | reverse the results of comparisons                       |
| -c      | check when the input is already sorted, don't sort if so |
| -o=FILE | write the output to FILE instead of the standard output  |
| -S      | buffer size                                              |

see the [manual](http://linuxcommand.org/man_pages/sort1.html) for more obscure flags.

### uniq

| Flag | Description                                 |
|:-----|:--------------------------------------------|
| -c   | prefix lines with the number of occurences  |
| -d   | only return duplicate lines                 |
| -f=N | skip the first N lines                      |
| -i   | ignore differences in case when comparing   |
| -s=N | skip the first N characters                 |
| -u   | only print unique lines                     |
| -w=N | compare no more than N characters in a line |

see the [manual](http://linuxcommand.org/lc3_man_pages/uniq1.html) for more obscure flags.

### grep

*Matcher Selection*

| Flag | Description                                                         |
|:-----|:--------------------------------------------------------------------|
| -E   | interpret pattern as an extended regular expression                 |
| -F   | interpret pattern as a list of fixed strings, separated by newlines |
| -G   | interpret pattern as a basic regular expression                     |
| -P   | interpret pattern as a perl regular expression (experimental)       |

*Matching Control*

| Flag       | Description                                  |
|:-----------|:---------------------------------------------|
| -e=PATTERN | allows for multiple patterns to be specified |
| -f=FILE    | obtain patterns from a file; one per line    |
| -i         | ignore case in pattern and input             |
| -v         | invert matching to select non-matching lines |
| -w         | match only full words                        |
| -x         | match only full lines                        |

*General Output Control*

| Flag | Description                                        |
|:-----|:---------------------------------------------------|
| -c   | print a count of matching lines                    |
| -l   | print only filenames containing matches            |
| -L   | print only filenames not containing matches        |
| -m   | stop reading a file after n matches                |
| -o   | print only the matching parts of the matched input |

*Output Line Prefix Control*

| Flag | Description                                              |
|:-----|:---------------------------------------------------------|
| -H   | print the file name with each match                      |
| -h   | suppress printing the file name with each match          |
| -n   | prefix each match with its line number in the input file |
|      |                                                          |

*File and Directory Selection*

| Flag                | Description                                           |
|:--------------------|:------------------------------------------------------|
| --exclude=GLOB      | exclude files whose names match GLOB                  |
| --exclude-from=FILE | exclude files with names matching GLOBs in FILE       |
| --exclude-dir=DIR   | exclude directories matching DIR (recursive searches) |
| --include=GLOB      | search only files whose names match GLOB              |
| -r                  | recursively search child directories/files            |

see the [manual](http://linuxcommand.org/lc3_man_pages/grep1.html) for more obscure flags.

### fmt

| Flag      | Description                                               |
|:----------|:----------------------------------------------------------|
| -p=PREFIX | reformat only lines beginning with PREFIX                 |
| -u        | uniform spacing; one between words, two between sentences |
| -w        | maximum line width                                        |

see the [manual](http://linuxcommand.org/lc3_man_pages/fmt1.html) for more obscure flags.

### head

| Flag    | Description                                               |
|:--------|:----------------------------------------------------------|
| -c=[-]N | print first N bytes of the file, or all but last -N bytes |
| -n=[-]N | print first N lines of the file, or all but last -N lines |

see the [manual](http://linuxcommand.org/lc3_man_pages/head1.html) for more obscure flags.

### tail

| Flag      | Description                                                |
|:----------|:-----------------------------------------------------------|
| -c=[+]N   | output last N bytes of the file, or all but first +N bytes |
| -f        | follow; output newlines as the file is appended to         |
| -n=[+]N   | output last N lines, or all but first +N lines             |
| --pid=PID | terminate -f once the process dies                         |
| --retry   | keep trying to open a file when it becomes inaccessible    |
| -s=N      | with -f, sleep N seconds between iterations                |

see the [manual](http://linuxcommand.org/lc3_man_pages/tail1.html) for more obscure flags.