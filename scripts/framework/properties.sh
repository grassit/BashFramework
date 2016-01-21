## Provides set of functions that allow managing properties files. Can read Java properties files

# Function return specified property from given property file
# Usage: read_property key filename
read_property() {
	key=$1
	file_name=$2
	# Read file and find the line contain property
	lines=`cat $file_name | grep $key`
	# Use the first line
	line=`echo $lines | head -n 1`
	
}

# Updates given property into the file. If doesn't exist then appends to end of file
# Usage: update_property key value filename
update_property() {
	:
}

