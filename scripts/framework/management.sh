# TODO: lists functions and their descriptions and modules
# Usage (to list all): functions
# Usage (to list from a particular module): functions filename
# Example: functions bash

# TODO: how to define a bash function with name taken from a variable. For example can I do following?
# MODULE_PREFIX="fn"
# function $MODULE_PREFIX_list() {}
# This would allow us to easily rename our functions and modules

# Shows the definition of a given function
fn_def() {
	:
	# TODO: here use grep with regular expressions to eliminate private functions that start with _
	# Also use string functions defined in string module to find index of the found functions. Then from that index find the index of } of previous function. 
	# Then find the index of next } relative to function name. Display the content between these two. Function name to previous index are comments,
	# Function name to next index is function body.
}

list_functions() {
	module_name=$1
	if [ -z "$module_name" ]; then
		echo "Please specify the module name."	
		return
	fi
	module=`find . -name "$module_name.sh"`
	funtions=`cat $module`
	# TODO: here use grep to search for 
}

# TODO: make add an argument to display only modules in a particular category
list_modules() {
	directories="`find $BASH_HOME/scripts -type d`"	

	for d in ${directories[@]}; do
		echo "=========="
		echo $(string_uppercase `basename $d`)
		# TODO: instead of outputting a fixed number of =, output equal to length of string
		echo "=========="
		modules="`find $d -maxdepth 1 -name '*.sh'`"
		for m in $modules; do
			echo `basename $m`
		done
		echo
	done
}

list_categories() {
	directories="`find $BASH_HOME/scripts -type d`"

	for d in ${directories[@]}; do
		echo `basename $d`
		# TODO: instead of outputting a fixed number of =, output equal to length of string
	done	
}

# Shows usage syntax for a function
usage() {
	:
}

# Launches a SSH session to the remote system automatically calling install_framework and installing in /tmp and sourcing it, so that the
# commands are available as soon as you get the prompt.
__ssh_() {
	:
}