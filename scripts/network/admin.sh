## Monitor the network traffic for a particular command
######
# Usage: monitor_network command
# Example: monitor_network git svn fetch
alias monitor_network='strace -f -e trace=network -s 10000' 
alias network_trace='strace -f -e trace=network -s 10000' 
