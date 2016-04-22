### This file scans and imports the python modules defined in the framework
################


# Argument to this script is the list of file names

import sys
sys.path.insert(0, '/path')

import [my-module

# Caling function dynamically
method = getattr([my-module], 'function-name')
result = method()
