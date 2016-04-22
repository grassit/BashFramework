### This file is for general purpose bash programming related functions. For example, function to find filename from path or length of the string
### TODO: remove non programming related functions to other file. find command should be in system programs script. To bash it is just another exe
### Its not specific to bash.

# TODO: move the functions in this file to their proper modules and delete this file

# Define the prompt to be colored and short
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

declare -r SUCCESS=0
declare -r ERROR=1

# TODO: define function
# Find and open. Finds a subdirectory matching given name pattern and opens it.
# Example: fo c.india.t opens Customers/air-india/trunk
fo() {
	:
}

# Display cowsay
# TODO: replace cowsay with more useful information such as number of new mails you have sent by cron jobs
# Or by important reminders such as list of TODOs. You hardly look at cowsay anymore. You could scan all shell files and pick first few TODOs to display
# TODO: this statement should only be executed if cowsay and fortune exist on the system. Otherwise bashframework displays an error on startup.
fortune | cowsay

dirsize() {
    du --max-depth=1 -h
}

# Reads and returns value of a variable whose name is specified as an argument
# Usage: varvalue=$(read_var var_with_varname)
# Arrays returned from bash functions get flattened into a string. In that case wrap above expression inside a () to convert back to array.
# Thus the usage with arrays would be: varvalue=($(read_var var_with_varname))
read_var() {
	echo $(eval echo \${$1[@]})
}

# Removes elements from the array based on a given regex pattern.
# Usage: filter_arr pattern array
# Usage: filter_arr pattern element1 element2 ...
remove_all() {	
	arr=($@)
	arr=(${arr[@]:1})
	dirs=($(for i in ${arr[@]}
		do echo $i
	done | grep -v $1))
	echo ${dirs[@]}
}

retain_all() {	
	arr=($@)
	arr=(${arr[@]:1})
	dirs=($(for i in ${arr[@]}
		do echo $i
	done | grep $1))
	echo ${dirs[@]}
}

# Subtracts one array from another
subtract_array() {
	:
}

# Returns the filename from the given path
file_name() {
	echo "This command is deprecated. Use builtin command basename for this."
}

# Returns the filename from the given path without extension
# Command: extension /tmp/abc.tar.gz.1
# Output: abc
file_base_name() {
	name=$(basename $1)
	ext=$(file_ext $name)
	echo ${name%.$ext}
}

# Returns the extension from the given path
# Command: extension /tmp/abc.tar.gz.1
# Output: tar.gz.1
file_ext() {
	extension=$(basename $1)
	echo ${extension#*.}
}

# Shows displays progress of a task in percentage
# Usage: show_progress step current total
# Example: show_progress 5 23 330
# Means show progress in steps of 5% (no 2, 3, 3.4%) for 23 items processed out of 330
# TODO: currently does not have step functionality. Add it.
progress=0
show_progress() {
	p=$(round $(echo "$2/$3*100" | bc -l))

	if [ $p != $progress ]; then
		progress=$p
		echo $progress
	fi
}

# TODO: define function that allows reading standard input and passing it as parameter to another function. xargs builtin does not work with
# user defined functions.
_xargs() {
	:
}


#TODO: define a function that supresses rm on ~, /, /opt and all top level directories. Instead of removing /tmp you should remove stuff inside /tmp

