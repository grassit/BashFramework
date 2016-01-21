###########
## Commands related to disk and files
###########

# Display list of active internet connections: netstat -n -A inet
# List of ports listening on local: netstat --listen -A inet
# List all network connections by a given process: lsof -i4TCP -a -p 23456

# We replace the system du because by default it prints entire subdirectory tree which isn't useful
# TODO: show output in this form:
# Current directory total size: 1GB
# Petty files cumulative size: 2MB (Count: 282)
# Size sorted files
declare -r DEFAULT_PETTY_LIMIT=$KB
du() {
	rows=(`_du --max-depth=1 | sort -t " " -k 1 -g`) 
	petty_limit=$DEFAULT_PETTY_LIMIT
	petty_count=0
	petty_size=0
	for (( i = 0; i < ${#rows[@]}; i+=2 )); do
		if (( ${rows[$i]} < $petty_limit )); then
			petty_size=`expr $petty_size + ${rows[$i]}`
			petty_count=`expr $petty_size + 1`
		#else (( ${rows[$i]} < $MB )); then
			:
			#statements
		fi
		# Idea: we could define a function for printing array elements with new lines
		# Idea2: we could define a function for inserting \n or any char into array
		# Idea3: something better yet, to be thought in morning.
	done
}

_du() {
	/usr/bin/du "$@"
}

# Converts size in bytes to readable units
# Example: readable_size 3000 gives 2KB
# Example: readable_size 1200000 gives 1MB
declare -r KB=1024
declare -r MB=`expr $KB \* $KB`
declare -r GB=`expr $MB \* $KB`
#TODO: we should use the inbuilt command numfmt inside this function
# Example for converting to GB:
# numfmt --to=iec-i --suffix=B --format="%3f" 4953205820
readable_size() {
	bytes="$1"
	if [[ -z $bytes ]]; then
		:
	elif (( $bytes < $MB )); then
		echo `expr $bytes / $KB`KB
	elif (( $bytes < $GB )); then
		echo `expr $bytes / $MB`MB
	else
		echo `expr $bytes / $GB`GB
	fi
}


# Replaces all occurences of given string in all files and subdirectories recursively
# Usage: replace_all file_name_pattern text_to_search replacement
replace_in_files() {
	file_name_pattern="$1"
	text_to_search="$2"
	replacement="$3"

	info Before replacement operation
	info ============================
	grep -R --include="$file_name_pattern" "$text_to_search" .

	find . -type f -name "$file_name_pattern" | xargs sed -i "s/$text_to_search/$replacement/g"

	info ============================
	info After replacement operation
	info ============================
	grep -R --include="$file_name_pattern" "$text_to_search" .
}

# finds by name in subdirectories. Ignores permission and other errors.
findn() {
    find . -name "*$1*" 2>/dev/null
}