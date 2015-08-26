##############
### This module defines various functions that make working with SSH easier
##############

# SSHes to a named server
# Usage: ssh_ server-name
# Example: ssh_ dev_robot
ssh() {
	server_name=$1
	server=($(read_var servers_$server_name))

	ip=${server[0]}
	username=${server[1]}
	password=${server[2]}
	info "sshpass -p **** ssh $username@$ip"
	sshpass -p "$password" ssh $username@$ip
}
_ssh() {
	/usr/bin/ssh "$@"
}

# Creates a tunnel between a local port and a remote port
# Usage: tunnel remote-server-name port gateway-name
# Example: tunnel centos 1521 localhost (Read as: tunnel to centos 1521 via localhost)
tunnel() {
	server_name=$1
	server=($(read_var servers_$server_name))
	port=$2
	gateway_name=$3
	gateway=($(read_var servers_$gateway_name))

	server_address=${server[0]}
	gateway_address=${gateway[0]}
	gateway_username=${gateway[1]}
	gateway_password=${gateway[2]}

	info "sshpass -p \"$gateway_password\" ssh -L $port:$server_address:$port $gateway_username@$gateway_address -Nv"
    sshpass -p "$gateway_password" ssh -L $port:$server_address:$port $gateway_username@$gateway_address -Nv
}

# Mounts given remote server over ssh under $SSHFS_MOUNT_POINT/server-name
# By defaults as a readonly file system.
# TODO: ssh pass is not working with sshfs. Need to figure out some way to automated password input. Till then enter manually.
SSHFS_MOUNT_POINT=/mnt/sshfs
DEFAULT_MOUNT_DIR="/"
sshmount() {
	server_name=$1
	server=($(read_var servers_$server_name))

	ip=${server[0]}
	username=${server[1]}
	password=${server[2]}
	
	if [ -n "$username" ]; then
		mkdir -p $SSHFS_MOUNT_POINT/$1 
		fusermount -u $SSHFS_MOUNT_POINT/$1 
		info "sshfs $username@$ip:$DEFAULT_MOUNT_DIR $SSHFS_MOUNT_POINT/$1 -o ro"
    	sshfs $username@$ip:$DEFAULT_MOUNT_DIR $SSHFS_MOUNT_POINT/$1 -o ro
	else
		error "Server name $server_name not in list."
	fi
}

# Copies given path to server, gzipping automatically if required
# By default copies in user's home directory. Overwrites any existing files.
# Usage: scp server_name /path
scp() {
	server_name=$1
	path="$2"
	server=($(read_var servers_$server_name))

	address=${server[0]}
	username=${server[1]}
	password=${server[2]}

	if [[ `is_dir $path` = $TRUE ]]; then
		cd $path;cd ..;
		file=/tmp/`basename $path`.tar.gz
		tar -zcvf $file `basename $path`
	else
		file=$path
	fi
	info "_scp_ $file $username@$address:"
	_scp_ $file $username@$address:
}

_scp_() {
	/usr/bin/scp "$@"
}

unmountall() {
	fusermount -u $SSHFS_MOUNT_POINT/*
}