# Maps given FQDN to localhost instead of its actual IP. Can be used for redirecting requests to a domain to localhost
map_to_local() {
	echo "$1 >> /etc/hosts"
	echo "127.0.0.1    $1" >> /etc/hosts
}

# Kills the process listening on the given port
kill_port() {
	# fuser -k $1/tcp
	:
}

# Captures the network traffic for a particular program and dumps it to disk
declare -r DUMP_LOCATION='/tmp'
capture_traffic() {
	:
}

cntlm_start() {
	sudo cntlm -v > /var/log/cntlm.log 2>&1 &
}