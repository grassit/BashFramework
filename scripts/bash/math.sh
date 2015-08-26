
# Usage: modulo 20 3
# TODO: not working
modulo() {
	echo "$1%$2" | bc
}

# Rounds a decimal to given number of decimal digits. 
# Example: round 1.3333 2 gives 1.33
# Example: round 1.3333 6 gives 1.333300
# If number of decimal digits not specified, rounds to integer
# Example: round 1.3333 gives 1
round() {
	number="$1"
	digits="$2"
	if [[ -z "$digits" ]]; then
		digits=0
	fi

	echo $(printf %."$digits"f $number)
}