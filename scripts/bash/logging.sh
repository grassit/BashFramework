##############
## Defines logging functions
##############

# Color codes used for different logging levels
ERROR_COLOR=RED
INFO_COLOR=BLUE

# Replace the inbuilt info because that command is useless
info() {
	message="$1"
	echoc "$message" BLUE
}

error() {
	message="$1"
	echoc "$message" RED
}