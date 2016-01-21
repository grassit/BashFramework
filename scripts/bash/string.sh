###

#MODULE_PREFIX=str

# Function to extract substring from string basis a regex. Returns nothing if no match
# Usage: str_regex_extract string regex
# Example: str_regex_extract 'kshitiz sharma' 'iti'
# Output: iti
str_regex_extract() {
	string=$1
	regex=$2
	match=`echo $string | sed "s/^.*\($regex\).*$/\1/"`

	# if [[ $match != $string ]]; then
	# 	echo $match
	# fi
	echo $match
}

# Function to get string between two regex matches but not the matches themselves. 
# Only first occurence of first regex and second regex is considered. Second matcher is applied after the index of first match.
# Usage: str_regex_substring string first_matcher second_matcher
# Example: str_regex_substring 'kshitiz sharma' 'k' 'i'
# Output: sh
str_regex_substring() {
	string="$1"
	first_matcher="$2"
	second_matcher="$3"
	first_match_index=`str_regex_index "$string" "$first_matcher"`
	#If the first regex not found or found at the very end of string, return nothing
	if [[ $first_match_index == -1 ]] || [[ $(($first_match_index+1)) == `str_len "$string"` ]]; then
		return
	fi
	remaining_string=`str_substring "$string" $(($first_match_index+1))`
	second_match_index=`str_regex_index "$remaining_string" "$second_matcher"`	
	echo `str_substring "$remaining_string" 0 $(($second_match_index-1))`
}

# Returns the zero based index of first match in a string. Returns -1 if no match.
# Usage: str_regex_index string regex
# Example: str_regex_index 'kshitiz' i
# Output: 3
str_regex_index() {
	string="$1"
	regex="$2"
	matched_string=`str_regex_extract "$string" "$regex"`
	if [[ `str_isempty "$matched_string"` == $TRUE ]]; then
		echo -1
	else
		index=`str_indexof "$string" "$matched_string"`
		echo $index
	fi
}

# Gets length of a string
str_len() {
	string=$1
	echo ${#string}
}

# Gets the substring between given two indexes
# Second index is optional. If not provided gets the substring to string length
# TODO: allow specification of negative indices to allow getting characters from back, for example getting last three characters from back substring $str -3
# Usage: 
str_substring() {
	string="$1"
	first_index=$2
	second_index=$3

	if [[ -z $second_index ]]; then
		second_index=$(str_len "$string")
	fi
	
	length=$(($second_index-$first_index+1))
	echo "${string:$first_index:$length}"
}

# Finds the index of a substring in given string
# Usage: indexof string substring
# Returns -1 if not found
str_indexof() {
	index=$(awk -v a="$1" -v b="$2" 'BEGIN{print index(a,b)}')
	echo $((index-1))
}

# Returns list of line numbers in which given string occurs
str_lineof() {
	:
}

# Returns index of last occurence of substring in string
# Returns a negative number if not found
str_lastindexof() {
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
str_replace() {
	string=$1
	regex=$2
	replacement=$3
	echo ${string/$regex/$replacement}
}

# TODO: defect, collapses multiple spaces in string
str_replace_all() {
	string=$1
	regex=$2
	replacement=$3
	echo ${string//$regex/$replacement}
}

# Deletes all matches of given regex from a string
# Usage: string_replace string select replacement
str_delete_all() {
	string=$1
	regex=$2
	replacement=''
	echo ${string//$regex/$replacement}
}

str_trim() {
	:
}

# Example: str_ends_with puppy y
str_ends_with() {
	string=$1
	substring=$2
	if [[ $string == *$2 ]]; then
		echo $TRUE
	else
		echo $FALSE
	fi
}

# Example: str_ends_with puppy p
str_starts_with() {
	string=$1
	substring=$2
	if [[ $string == $2* ]]; then
		echo $TRUE
	else
		echo $FALSE
	fi
}

# Returns the character at given index
str_char_at() {
	:
}

str_isempty() {
	if [[ -z $1 ]]; then
		echo $TRUE
	else
		echo $FALSE
	fi
}

# Collapses multiple spaces in middle of string to single space
# IMPORTANT: argument should this function should be passed in quotes or else it will not consider the whole string, only the first word.
# TODO: does not work if the string has " or '. Redefine this function to be more generic.
str_trim_all() {
	if [[ `assert_max_args "$#" 1` = $ERROR ]]; then
		# TODO: replace with error() function from logging
		echo $ERROR_MAX_ARGS
	 	return
	fi 
	echo "$1" | sed -r 's/[  ]+/ /g'
}

# Gets a particular line number from given multiline text
# Example: get_line "$text" 3
str_line() {
	assert_max_args "$#" 2
	text="$1"
	number=$2
	echo "$text" | sed -n "$number"p
}

# Returns true if a string contains given substring
# Usage: string_contains "$string1" "$string2"
str_contains() {
	string="$1"
	substring="$2"
	if [[ `indexof $string $substring` = "-1" ]]; then
		echo $FALSE
	else
		echo $TRUE
	fi
}

# Converts given text to uppercase
# Usage: str_uppercase $string
# Example: str_uppercase apple
str_uppercase() {
	echo $1 | awk '{print toupper($0)}'
}

# Converts given text to lowercase
str_lowercase() {
	echo $1 | awk '{print tolower($0)}'
}

str_is_lowercase() {
	:
}

str_is_uppercase() {
	:
}

# Splits a string into two basis a regex
# Example: str_split "kshitiz-sharma-bash" "-"
# Output: "kshitiz" "sharma" "bash"
str_split() {
	:
}

# Same as split but applies the pattern only n times
# Example: str_split "kshitiz-sharma-bash" "-" 1
# Output: "kshitiz" "sharma-bash"
str_split_n() {
	:
}

# Replace all matches of given regex with given string
# Example: str_regex_replace_all "/a//b///c" '\/\/*' '\/'
# Output: /a/b/c
str_regex_replace_all() { 
    string=$1;
    regex=$2;
    replacement=$3;
    echo `echo $string | sed s"/$regex/$replacement/g"`
}