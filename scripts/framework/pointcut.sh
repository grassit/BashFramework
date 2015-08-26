# TODO: can we define a custom function that sources our bash functions, instead of directly sourcing them with source builtin?
# Maybe this would allow us to modify the function definitions while loading them. For example, we could define our functions with a comment based annotation
# such as #@arg_count=3 and the sourcing function would include a guard clause in our function that automatically check for the required
# number of arguments.
# The gaurd clause can be defined in many ways. For example:

# pointcuts = ['pcut_check_arg_count' : 'list_module*']
# The above mapping would apply given function to all functions with whose name starts with list_module*

# Similarly, we can allow following selector types:
# Name based (fast)
# Module based (slow)
# Annotation based (slow)
# Argument value based (slow)
# Give appropriate warnings in documentation about performance impacts of these.

# Passed the arguments to the original function
pcut_check_arg_count() {
	# Here check the count of arguments is correct
	:
}

# Sources a given script and applies pointcuts
source_script() {
	:
}