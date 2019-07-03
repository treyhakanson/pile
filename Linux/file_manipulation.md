# File Manipulation

## Wildcards

Wildcards can be used for regexing in POSIX

| Wildcard      | Meaning                           |
|:--------------|:----------------------------------|
| *             | Matches any characters            |
| ?             | Matches any single character      |
| [chracters]   | Matches any of `characters`       |
| [!characters] | Matches anything but `characters` |

POSIX character classes can also be used in regexes, with the last two wildcards above (`[characters]`, `[!characters]`)

| Character Class | Meaning                                    |
|:----------------|:-------------------------------------------|
| [:alnum:]       | Alphanumeric chracters                     |
| [:alpha:]       | Alphabetic characters                      |
| [:digit:]       | Numerics                                   |
| [:upper:]       | Uppercase alphabetic characters            |
| [:lower:]       | Lowercase alphabetic characters            |
| [:punct:]       | Punctuation                                |
| [:space:]       | Whitespace characters                      |
| [:cntrl:]       | Control characters                         |
| [:graph:]       | Visible characters                         |
| [:print:]       | Visible characters and the space character |
| [:xdigit:]      | Hexadecimal digits                         |

keep in mind that to use a character class, the syntax would be as follows, with 2 sets of square braces:

```sh
# All names that begin with an uppercase letter
[[:upper:]]*
```

## cp

`cp` is used to copy files, and can handle copying multiple files at once:

```sh
# copy file1-3 into dir1
cp file1 file2 file3 dir1
```

`cp` can be used to copy content into a new file, or simply copy a file to a directory:

```sh
# -i specifies "interactive" meaning that if file2 already exists, the user
# will be warned before its contents are overridden
cp -i file1 file2

# -r specifies "recursive" meaning that directories will be created and copied
# as needed
cp -r dir1 dir2
```

## mv

`mv` works essentially the same as `cp`, but does need need a `-r` flag to copy directories. The `-i` flag is still available


## rm

removes files, also has a `-i` flag, and a `-r` for recursively deleting directories