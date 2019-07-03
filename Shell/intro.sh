# below is the interpreter line, which tells the shell which
# interpreter to run. In this case it is using the Bourne
# shell, which is also (usually) the default. It is best
# practice to specify this anyway. 
#!/bin/sh

# This line will simply grab the first argument entered after
# the shell command. Notice that variables are typically named
# in SCREAMING_SNAKE_CASE
FIRST_ARG="$1"

# referencing the variable is easy, but don't forget the $.
# The $ is the dereferencing operator, and calling it will insert
# the contents of the variable at that point in the shell script.
# that's why the $ is needed in front of 1 in the above line; it
# is dereferencing the value put into the first argument and inseting
# it into the script at that point.
echo "Hello World, $FIRST_ARG!"

# also note that echo is called above; any command that is available
# in the shell normally is also available from within a shell script
