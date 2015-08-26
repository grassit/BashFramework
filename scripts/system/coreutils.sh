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

