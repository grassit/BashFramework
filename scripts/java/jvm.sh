J7_HOME="/usr/lib/jvm/jdk1.7.0_40"
J8_HOME="/usr/lib/jvm/jdk1.8.0"
# Set last to make it default
J6_HOME="/usr/lib/jvm/jdk1.6.0_45"

######### Function to immediately switch Java version in PATH and JAVA_HOME ########
j6() {
# Delete existing entries from the path
PATH=${PATH/"$J6_HOME/bin"/}
PATH=${PATH/"$J7_HOME/bin"/}
PATH=${PATH/"$J8_HOME/bin"/}

PATH=$J6_HOME/bin:$PATH

# Fix any double colons left during replacement from middle of string. :: would mean current directory which is unintended.
export PATH=${PATH/::/:}

export JAVA_HOME=$J6_HOME

echo JAVA_HOME=$J6_HOME
}
j7() {
PATH=${PATH/"$J6_HOME/bin"/}
PATH=${PATH/"$J7_HOME/bin"/}
PATH=${PATH/"$J8_HOME/bin"/}
PATH=$J7_HOME/bin:$PATH
export PATH=${PATH/::/:}

export JAVA_HOME=$J7_HOME

echo JAVA_HOME=$J7_HOME
}
j8() {
PATH=${PATH/"$J6_HOME/bin"/}
PATH=${PATH/"$J7_HOME/bin"/}
PATH=${PATH/"$J8_HOME/bin"/}
PATH=$J8_HOME/bin:$PATH
export PATH=${PATH/::/:}

export JAVA_HOME=$J8_HOME

echo JAVA_HOME=$J8_HOME
}

####### Creates classpath from given directory. Can be used for setting classpath when running a Java command. ######
# Usage: java -jar jarname -cp `dir_to_cp /path/to/dependency_dir`
dir_to_cp() {
jars=$(find $1 2>/dev/null -name '*.jar')
cp=""
for f in $jars
do
	cp=$cp:$f
done
# Delete the obsolete leading colon
cp=${cp#:}

printf $cp
}

####### Expands to full set of arguments required to run JVM in debug mode #######
# Usage: java `DEBUG` -jar jarname
JVM_DEBUG() {
	echo -n '-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005'
}

# Provides list of JVMs that have an open network connection to a remote machine
jvm_remote_connections() {
	pids=$(ps -ef | grep java | grep -v grep)
	pids=$(string_trim_all "$pids" | cut -d " " -f 2)
	
	for pid in $pids; do
		process=$(netstat -tp 2>/dev/null | grep $pid)
		process=$(string_trim_all "$process")
		address=$(echo "$process" | cut -d " " -f 4)
		arg=$(ps -o args="" $pid)
		if [ $(isempty $address) = $FALSE ] && [ $(string_contains "$address" "local") = $FALSE ]; then
			printc "$address  " GREEN
			printc "$pid  " GREEN
			echo $arg
			echo
		fi
	done
}

# TODO: move to appropriate file
pid_to_name() {
	ps -eo "%p %a"
}