# Shell Scripting
all shell scripts start by specifying the intepreter, in what is aptly named the 'interpreter line'. By default, the shell will typically assume the interpreter to be the Bourne shell (/bin/sh), but for consistency it is best to specify it anyway.

## Adding Executable Scripts
in order for a script to be called from the terminal, it needs to have been made executable (using chmod) and needs to be located in a directory that has been added to the system PATH. To do this:
1. create a directory somewhere (mkdir ~/example)
2. add this directory to the PATH in ~/.bash_profile (export PATH=$PATH:~/example)
3. ensure it has been added (echo $PATH)

## Basic Process to Writing a Shell Script
1. Write the shell script, and save it to a .sh file
2. run "chmod a+x <filename>.sh" to make the file executable
3. run the file using "<path>/<filename>.sh"
