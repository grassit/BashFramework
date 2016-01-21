#############
### This file defines functions required for printing text in color
#############

# Color code constants
# NOTE: These colors may not appear as their descriptions here under different terminals and terminal themes.
# For example, on gnome-terminal LIGHTGREEN actually appears same as green with bold font.
declare -A COLORS
COLORS["BLACK"]='\033[0;30m'
COLORS["BLUE"]='\033[0;34m'
COLORS["GREEN"]='\033[0;32m'
COLORS["CYAN"]='\033[0;36m'
COLORS["RED"]='\033[0;31m'
COLORS["PURPLE"]='\033[0;35m'
COLORS["BROWN"]='\033[0;33m'
COLORS["LIGHTGRAY"]='\033[0;37m'
COLORS["DARKGRAY"]='\033[1;30m'
COLORS["LIGHTBLUE"]='\033[1;34m'
COLORS["LIGHTGREEN"]='\033[1;32m'
COLORS["LIGHTCYAN"]='\033[1;36m'
COLORS["LIGHTRED"]='\033[1;31m'
COLORS["LIGHTPURPLE"]='\033[1;35m'
COLORS["YELLOW"]='\033[1;33m'
COLORS["WHITE"]='\033[1;37m'
COLORS["NC"]='\033[0m' # No Color

# TODO: put all these names into array. Then do a case insensitive, match on the names.
# Like sqlplus If user says echo kshitiz w it means white because only that starts with w
# If user says bl that is amgigious because two colors like that. You could also say lr for light red. Or even ld.
# Alternatively you could use _ as modifier to make color light.

color=$BLACK

# Enhancement of echo builtin that prints text in color.
# TODO: modify this function to print in bold if specified as echo kshitiz BLACK BOLD
# Sample code for printing in bold:
# bold=$(tput bold)
# normal=$(tput sgr0)
# echo "this is ${bold}bold${normal} but this isn't"
echoc() {

	for arg in "$@"; do
		printc "$arg "
	done
	echo
}

# Prints text providing color as argument instead of using default color set by setcolor
# Usage: echoc "text" color_code
# Example: echoc kshitiz red
_echoc() {
	text="$1"
	color_name="$2"
	current_col=$CURRENT_COLOR
	setcolor $color_name
	echo "$text"
	CURRENT_COLOR=$current_col
}

# Prints text in given color without new line. No printf style arguments accepted.
# Usage: printc "text" color_code
# Example: printc RED kshitiz
printc() {
	color_name=`str_uppercase $1`
	text="$2"
	

	if [[ -z $color_name ]]; then
		code=$CURRENT_COLOR
	else
		code=$(eval echo \$$color_name)	
	fi

	printf "$code" # Set console color
    printf "%s" "$text"
    printf "$NC" # Restore console color, so as to not affect any other programs
}

# Changes the default color for echo
# Usage: setcolor color_name
# Example: setcolor RED
# TODO: add assertion to ensure that a valid color code is provided
setcolor() {
	CURRENT_COLOR=$(eval echo \$$1)
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


# kshitiz:~/.bash/scripts/system$ echo ${map[@]}
# cow
# kshitiz:~/.bash/scripts/system$ echo ${!map[@]}
# moo
# kshitiz:~/.bash/scripts/system$ echo map["moo"]
# map[moo]
# kshitiz:~/.bash/scripts/system$ echo ${map["MOO"]}
