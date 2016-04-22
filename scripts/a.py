#import sys
#for line in sys.stdin:
#    print line

# TODO: create a bridge betwen bash and python. So that python functions are directly callable from commandline and shell scripts.
# Perhaps have same reverse bride to call bash functions from python?
# Perhaps convert all the functions to bash? Have bash only as wrapper. It'll provide the same functionality with better code.

def read_stdin():
	import sys 
	text=''
	if not sys.stdin.isatty(): # If stdin contains input read it
		for line in sys.stdin:
			if line[-1] == '\n': # Remove the newline from end of string
				text = line[:-1]
			else:
				text = line
	print text

read_stdin()