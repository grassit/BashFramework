# This module defines functions that can be used to validate shell script file for conformance to best practices and framework conventions.
# Bash framework conventions are defined in README.md

# Checks that the file begins with proper readme header and that functions also have comment headers in proper formats
check_docs() {
	:
}

# Checks that arguments to the function are not referenced directly but first assigned to meaningful variable names
check_args() {
	:
}

# Checks that there are no magic value assignments to variables. All such values should be declared as constants. 
check_magic() {
	# Verifies that assignments always contain a variable
	# Good: a="adf$b"
	# Bad: a="adf"
	:
}

# Checks that all assignments are quoted
check_quote() {
	:
}

# Checks that all usages of string variables are quoted
# This can be accomplished by explicitly marking certain variables as string during declaration
# After that all occurances of that variable should be quoted
check_string_quote() {
	:
}

# Checks that all occurences of echo are quoted
check_echo_quote() {
	:
}

# Checks that when system programs are overriden a replacement is provided via _ syntax
check_overrides() {
	:
}

# Checks all the modules in the framework
check_all_modules() {
	:
}