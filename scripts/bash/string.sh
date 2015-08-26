# Function to extract substring from string basis a regex
# Usage: substring string regex
regex_substring() {
	echo $1 | sed "s/^.*\($2\).*$/\1/"
}

# Gets length of a string
strlen() {
	string=$1
	echo ${#string}
}

# Gets the substring between given two indexes
# Second index is optional. If not provided gets the substring to string length
# TODO: allow specification of negative indices to allow getting characters from back, for example getting last three characters from back substring $str -3
substring() {
	string=$1
	first_index=$2
	second_index=$3

	if [[ -z $second_index ]]; then
		second_index=$(strlen $string)
	fi
	
	length=$(($second_index-$first_index+1))
	echo ${string:$first_index:$length}
}

# Finds the index of a substring in given string
# Usage: indexof string substring
# Returns -1 if not found
indexof() {
	index=$(awk -v a="$1" -v b="$2" 'BEGIN{print index(a,b)}')
	echo $((index-1))
}

# Returns index of last occurence of substring in string
# Returns a negative number if not found
lastindexof() {
	string=$1
	substring_length=$(strlen $2)
	# Find first index
	index=$(indexof $string $2)
	last_index=$index # variable to handle last successful index
	
	removed=0
	until [ $index = -1 ]; do
		last_index=$index
		string=$(string_replace $string $2)
		removed=$(($substring_length+$removed)) # Number of characters removed from string
		index=$(indexof $string $2)
	done
	# -1 because by this point all occurences would have been removed which is not right, we want to remove all but one
	echo $(($last_index+$removed-1))
}

# Replace first occurence of a substring or regex with given string
# Usage: string_replace string select replacement
string_replace() {
	string=$1
	echo ${string/$2/$3}
}

# TODO: defect, collapses multiple spaces in string
string_replace_all() {
	string=$1
	echo ${string//$2/$3}
}

string_trim() {
	:
}

isempty() {
	if [[ -z $1 ]]; then
		echo $TRUE
	else
		echo $FALSE
	fi
}

# Collapses multiple spaces in middle of string to single space
# IMPORTANT: argument should this function should be passed in quotes or else it will not consider the whole string, only the first word.
# TODO: does not work if the string has " or '. Redefine this function to be more generic.
string_trim_all() {
	if [[ `assert_max_args "$#" 1` = $ERROR ]]; then
		# TODO: replace with error() function from logging
		echo $ERROR_MAX_ARGS
	 	return
	fi 
	echo "$1" | sed -r 's/[  ]+/ /g'
}

# Gets a particular line number from given multiline text
# Example: get_line "$text" 3
get_line() {
	assert_max_args "$#" 2
	text="$1"
	number=$2
	echo "$text" | sed -n "$number"p
}

# Returns true if a string contains given substring
# Usage: string_contains "$string1" "$string2"
string_contains() {
	string="$1"
	substring="$2"
	if [[ `indexof $string $substring` = "-1" ]]; then
		echo $FALSE
	else
		echo $TRUE
	fi
}

string_uppercase() {
	echo $1 | awk '{print toupper($0)}'
}