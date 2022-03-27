# bash-error-handling

## The Set Builtin

This builtin is so complicated that it deserves its own section. set allows you to change the values of shell options and set the positional parameters, or to display the names and values of shell variables. [4.3.1 The Set Builtin](https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin)

Here we are going to use this options:
 - `-e` Exit immediately on failure
 - `-u` Exit when there is an unbound variable
 - `-o` Give a option-name to set
   - pipefail The return values of last (rightmost) command (exit code)
 - `-v` Print all shell input lines as they are read
 - `-x` Print trace of commands


