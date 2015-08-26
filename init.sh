## This file sets up BashFramework. It executes all the script files present in the framework.
## It will be executed EVERY time a new terminal window is opened

# The files are sourced from $BASH_HOME or from ~/.bash if $BASH_HOME is not set.
if [ -z "$BASH_HOME" ]; then
  BASH_HOME=~/.bash
fi

# Sort the files. Files should be named in such a way that files dependant on other files should come lower in list.
_dirs=$(find $BASH_HOME -name '*.sh' | sort)

# Source all the files
for d in $_dirs; do
    if [[ "$d" =~ .*init.sh ]]; then # exclude sourcing self
        :
    else
        source $d
    fi
done
