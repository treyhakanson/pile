# I/O Redirection

By default, programs standard output is directed to the display. This can be redirected anywhere, such as a file:

```sh
# ">" specifies redirection of output
ls > file.txt
```

`>` will override the contents of the output stream; use `>>` to append:

```sh
# ">>" will not override the contents of file.txt
ls >> file.txt
```

`>>` will create the file if it does not exist.

can specify a standard input stream as well, so that something like a file's contents can be fed into a command:

```sh
# sort the contents of the input stream, file.txt, using "<"
sort < file.txt
```

The pipe operator, `|`, can be used to redirect the output stream of one command into another command as the input stream:

```sh
# redirect the results of the ls command into the less command
ls -l | less
```

