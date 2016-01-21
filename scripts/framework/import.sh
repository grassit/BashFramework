### This file defines functions that allow you to import modules so that it is possible to reference their functions without specifying module prefix

import() {
	module_name=$1
	:
	# Find the name of all the functions in the module

	# Define and export new bash functions as wrapper over these functions
	eval "ab() { echo test; }"
}


