# TODO: lists functions and their descriptions and modules
# Usage (to list all): functions
# Usage (to list from a particular module): functions filename
# Example: functions bash

# TODO: how to define a bash function with name taken from a variable. For example can I do following?
# MODULE_PREFIX="fn"
# function $MODULE_PREFIX_list() {}
# This would allow us to easily rename our functions and modules

#MODULE_PREFIX="fn"

# Shows the definition of a given function
# Usage: fn_def function-name
# Example: fn_def ???
fn_def() {
	:
	# TODO: here use grep with regular expressions to eliminate private functions that start with _
	# Also use string functions defined in string module to find index of the found functions. Then from that index find the index of } of previous function. 
	# Then find the index of next } relative to function name. Display the content between these two. Function name to previous index are comments,
	# Function name to next index is function body.
}

# Function to print list of functions in a module
# Usage: fn_list module-name
# Example: fn_list dir
fn_ls() {
	module_name=$1
	# TODO: use assert function instead of manual check
	if [ -z "$module_name" ]; then
		echo "Please specify the module name."	
		return
	fi
	module=`find . -name "$module_name.sh"`
	functions=`cat $module`
	echo "$functions" | grep "Usage: "

	# TODO: here use grep to search for 
}

# Prints list of packages in framework. Takes no argument
# Usage: fn_ls_package
# Usage: fn_ls_package
fn_ls_package() {
	directories="`find $BASH_HOME/scripts -type d`"	
	i=0
	for d in ${directories[@]}; do
		echo "$i)"`basename $d`
		i=$((i+1))
	done
}

# Function to print list of modules in the framework
# Usage: fn_ls_mod module-name
# TODO: make add an argument to display only modules in a particular category
fn_ls_mod() {
	module_name=$1
	directories="`find $BASH_HOME/scripts -name $module_name -type d`"	

	for d in ${directories[@]}; do
		modules="`find $d -maxdepth 1 -name '*.sh'`"
		for m in $modules; do
			echo `basename $m`
		done
	done
}

fn_list_cat() {
	directories="`find $BASH_HOME/scripts -type d`"

	for d in ${directories[@]}; do
		echo `basename $d`
		# TODO: instead of outputting a fixed number of =, output equal to length of string
	done
}

# Outputs all the modules and functions in the framework
fn_ls_all() {
	directories="`find $BASH_HOME/scripts -type d`"	

	for d in ${directories[@]}; do
		echo "=========="
		echo $(str_uppercase `basename $d`)
		# TODO: instead of outputting a fixed number of =, output equal to length of string
		echo "=========="
		modules="`find $d -maxdepth 1 -name '*.sh'`"
		for m in $modules; do
			echo `basename $m`
		done
		echo
	done
}


# Shows usage syntax for a function
fn_usage() {
	:
}

# Launches a SSH session to the remote system automatically calling install_framework and installing in /tmp and sourcing it, so that the
# commands are available as soon as you get the prompt.
__ssh_() {
	:
}