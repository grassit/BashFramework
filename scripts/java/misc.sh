# Uses intellij diff to diff two files
IDEA_HOME="/opt/intellij14.1/"
dif() {
	file1=$1
	file2=$2
	`$IDEA_HOME/bin/idea.sh diff $file1 $file2`
}

start_jenkins() {
	j8
	$JENKINS_HOME/bin/startup.sh
}

stop_jenkins() {
	$JENKINS_HOME/bin/shutdown.sh
}

# Kills all running tomcat instances
# TODO: refactor to make it more understandable
kill_tomcat() {
	pids=$(ps -eo pid,cmd | grep tomcat | grep -v grep | sed -n 's/.*\(^.[0-9]*\).*/\1/p')

	for i in ${pids}
	do
	   echo Killing PID - $i
	   $(kill -9 $i)
	done
}