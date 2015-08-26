############################
### This files defines functions for managing named servers stored in server_list.sh
###########################

# Shows the list of servers defined
# TODO: categorize and display only names. Instead of doing this with some hack that is specific to this case try creating a function that returns list of all variables defined in a file or list of all variables in environment that match a certain name
# TODO: FRAMEWORK_HOME section has become dynamic but file path "/" is still considered hardcoded. Instead have framework_home as part of init.sh
# and make it ~/.bash and then do a find on that to get to server_list.sh
# TODO: Move this to init.sh or some other file
FRAMEWORK_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
server_list() {
	cat $FRAMEWORK_HOME/server_list.sh
}

# Defines a given named server temporarily
# Usage: define server_name username/password@serveraddress
# TODO: check that the input is in correct format. Assert regex: [a-zA-Z]*/[a-zA-Z]*@[a-zA-Z.-]*
declare -r SELF_NAME='servers.sh'
define() {
	server_name=$1

	index_slash=$(indexof $2 "/")
	index_at=$(indexof $2 "@")

	username=$(substring $2 0 $(($index_slash-1)))
	password=$(substring $2 $(($index_slash+1)) $(($index_at-1)))
	address=$(substring $2 $(($index_at+1)))

	info "eval \"declare -a servers_$server_name=(\"$address\" $username $password);\""
	eval "servers_$server_name=("$address" $username $password);"
}

# Saves a given named server by appending to the server list if not already exists
save_server() {
	:
}
