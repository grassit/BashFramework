### This file defines functions that allow you to import modules so that it is possible to reference their functions without specifying module prefix

# Character that should be used to separate words in a function name
# Example: str_len or str-len
declare -r WORD_SEPARATOR='_'

import() {
	module_name=$1
	:
	# Find the name of all the functions in the module

	# Define and export new bash functions as wrapper over these functions

	eval "ab() { echo test; }"
}

# Import process, bash scans the file system and invokes a python program that constructs appropriate import statements (this program can generate statements in a particular order basis module dependency that can be read from the files)
# Bash then takes these import statements and keeps in a shell variable (or a temp file if needed for performance)
# Bash then scans the list of defined python functions using grep it then defines shell functions that have same name as python functions
# These wrappers invoke the python command line with the name of the function aswell as arguments passed to wrapper


import_python() {
	# Find all python functions defined
	functions="`grep 'def' ~/.bash --include='*.py' -rh | sed s'/def //g' | sed s'/(.*//g'`"
	# Find all python files
	files=`cd $BASH_HOME; find . -name '*.py'`

	
	for f in $files; do
		local file_list=$file_list$f	
	done
	echo "$file_list"

	echo `python -c "print '\n'.join(['from %s import *'%f for f in '$file_list'.replace('.py', '').split()])"`

	echo $str
	#import_statement=`python -c "$str"`
	
	# Create import statement
	

	# Define wrappers to export the python function
}



