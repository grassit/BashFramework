# BASH-FRAMEWORK
BashFramework provides a comprehensive set of functions and conventions for simplifying development of Linux shell scripts that conform to best practices. It also provides functions that improvise the behaviour of system commands and automate routine tasks.

## USAGE
Simply place it your home directory (or any other directory of your choice) and add this line to your bashrc:
`source [INSTALL_LOCATION]/.bash/init.sh`


## CODE CONVENTIONS
Following code conventions are followed in scripts to make them more understandable.
- No hardcoded values or paths. Define constants at the top of the file in ALL_CAPS.
- Do not directly use $1, $2. Assign these to meaningful variables inside the function before using it. 
- As a general rule all usages of variables should be quoted. There should never be $1 $2 in a script. This would save a lot of effort in dealing with bugs that arise from not quoting string variables.
- Use asserts to check number of input parameters.
- Every function should have a comment on top with these three lines:
```
Description
Usage: 
Example:
TODO:
```
- All functions should echo the command that they ultimately construct and use. This will aid in learning the real commands.
- The echo from functions is colored for better readability:
BLACK output from system commands
BLUE info messages, what the function is trying to do
RED error messages, what the function couldn't do
- When system commands are improvised and replaced the original versions are made available via syntax _commandname. This would cause any third party scripts that rely on these programs to fail.
- Private functions are declared with double underscore like __private_funct() {}, These are for internal module use only and not to be invoked from other modules or directly by the user.


## NOTES
- Files that are dependant on other file and must be sourced in an order must be prefixed with a number. Example: 01_var.sh, 02_path.sh