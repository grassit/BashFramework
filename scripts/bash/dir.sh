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

# Concats two given paths. Handles path separator properly
# Example: dir_concat /abc/ efg ijk
# Output: /abc/efg/ijk
# Example: dir_concat abc/ efg/ ijk/
# Output: /abc/efg/ijk
dir_concat() {
    args=("$@")
    local path=""
    for p in ${args[@]}; do
        path=$path$p/
    done
    # Remove multiple slashes
    path=$(str_regex_replace_all "$path" '\/\/*' '\/')
    # Remove trailing slash
    path=$(str_regex_replace_all "$path" '\/$' '')
    echo $path
}
