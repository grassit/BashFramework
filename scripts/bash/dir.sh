# Check if path is a directory
# Usage is_dir /path
is_dir() {
	path="$1"
	if [[ -d "$path" ]]; then
    	echo $TRUE
    else
    	echo $FALSE
    fi
}

# Check if path is a file
# Usage is_file /path
is_file() {
	path="$1"
	if [[ -f "$path" ]]; then
    	echo $TRUE
    else
    	echo $FALSE
    fi
}