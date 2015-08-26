#############
### This file defines functions required for printing text in color
#############

# Color code constants
# NOTE: These colors may not appear as their descriptions here under different terminals and terminal themes.
# For example, on gnome-terminal LIGHTGREEN actually appears same as green with bold font.
BLACK='\033[0;30m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
BROWN='\033[0;33m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTBLUE='\033[1;34m'
LIGHTGREEN='\033[1;32m'
LIGHTCYAN='\033[1;36m'
LIGHTRED='\033[1;31m'
LIGHTPURPLE='\033[1;35m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# TODO: put all these names into array. Then do a case insensitive, match on the names.
# Like sqlplus If user says echo kshitiz w it means white because only that starts with w
# If user says bl that is amgigious because two colors like that. You could also say lr for light red. Or even ld.
# Alternatively you could use _ as modifier to make color light.

CURRENT_COLOR=$BLACK

# Enhancement of echo builtin that prints text in color.
# TODO: modify this function to print in bold if specified as echo kshitiz BLACK BOLD
# Sample code for printing in bold:
# bold=$(tput bold)
# normal=$(tput sgr0)
# echo "this is ${bold}bold${normal} but this isn't"
# TODO: Look up from git repo and restore it properly. We can't override echo as it'd be used too many scripts out there and the replacement isn't
# safe from side effects. It outputs invisible color characters which choke up third party programs.
echoc() {
	for arg in "$@"; do
		printc "$arg "
	done
	_echo
}

_echo() {
	builtin echo "$@"
}

# Prints text providing color as argument instead of using default color set by setcolor
# Usage: echoc "text" color_code
# Example: echoc kshitiz red
echoc() {
	text="$1"
	color="$2"
	current_col=$CURRENT_COLOR
	setcolor $color
	echo "$text"
	CURRENT_COLOR=$current_col
}

# Prints text in given color without new line. No printf style arugments accepted.
# Usage: printc "text" color_code
printc() {
	if [[ -z $2 ]]; then
		code=$CURRENT_COLOR
	else
		code=$(eval _echo \$$2)	
	fi
	printf "$code"
    printf "%s" "$1"
    printf "$NC"
}

# Changes the default color for echo.
# TODO: add assertion to ensure that a valid color code is provided
setcolor() {
	#echo "CURRENT_COLOR=$(echo $1)" BLUE
	CURRENT_COLOR=$(eval _echo \$$1)
}

# Prints the available color palette
color_palette() {
	echoc BLACK BLACK
	echoc BLUE BLUE
	echoc GREEN GREEN
	echoc CYAN CYAN
	echoc RED RED
	echoc PURPLE PURPLE
	echoc BROWN BROWN
	echoc LIGHTGRAY LIGHTGRAY
	echoc DARKGRAY DARKGRAY
	echoc LIGHTBLUE LIGHTBLUE
	echoc LIGHTGREEN LIGHTGREEN
	echoc LIGHTCYAN LIGHTCYAN
	echoc LIGHTRED LIGHTRED
	echoc LIGHTPURPLE LIGHTPURPLE
	echoc YELLOW YELLOW
	echoc WHITE WHITE
}
