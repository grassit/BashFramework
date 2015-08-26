#########
## Contains set of assertions that can be used to fail fast and display meaningful error messages instead of letting 
# the function continue with incorrect environment and show cryptic message. Or worse: do unintended operations.
#########

# Checks that the count of input argument is as expected
# Usage: assert_max_args [received-arg-count] [max-count]
# Example: assert_max_args "$#" 5

ERROR_MAX_ARGS='Too many parameters. When passing in text remember to quote the parameters. "$text" instead of $text'

assert_max_args() {
	actual="$1"
	max="$2"
	if (( "$actual" > "$max" )); then
		echo $ERROR
	fi
}
