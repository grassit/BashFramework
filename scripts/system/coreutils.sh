###############
### File for functions related to GNU coreutils. For example: ls, cp, rm etc 
###############

alias ls='ls -ltrh --color=auto'

_ls() {
	:
}

# Grep function to display not just individual lines but some context. Amount of context controlled by a passed in parameter.
# So for example: better_name_grep -c 3 expression filename
# Would show the matching files plus 3 lines from top and below
# TODO: 
better_name_grep() {
	:
}

# Improves the ls command to be usable with better flags such as -time -asc instead of -
#ls() {
#
#}

# This function replaces the inbuilt rm command to provide following functionalities
# Moves files to Trash instead of deleting them. Empties trash if full or above given quota
# Ignore rm commands on system directories
# Maintains a log of file deletions and command runs in data/logs/bash-framework/rm{date}.log

declare -r TRASH_LOCATION="/home/$USER/.local/share/Trash/files"
declare -a PROTECTED=("/")

# Function to initialize the required variables for rm function
__rm_init() {
	# All top level directories are protected
	top_dirs="`/bin/ls /`"
	for d in "$top_dirs"; do
		echo "d"
	done
	echo abc
}
#echo `__rm_init` # Invoke the init function

_rm() {
	:
}

