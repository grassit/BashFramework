####### Expands to arguments required to run maven without tests #######
# Usage: mvn `NOTEST` package
NOTEST() {
printf "%s"	"-Dmaven.test.skip=true"
}

MVN_DEBUG() {
printf "%s"	"-Dmaven.surefire.debug"
}

NODOC() {
printf "%s"	"-Dmaven.javadoc.skip=true"	
}

IGNORE_SSL_ERROR() {
printf "%s"	"-Dmaven.wagon.http.ssl.insecure=true"
}

DOWNLOAD_SOURCES() {
printf "%s"	"-DdownloadSources=true"
}

# Displays the dependency tree like maven view in intellij
# TODO: modify the function to cut out the extra cruft printed. Or better yet explore maven options to see if you could reduce verbosity.
mvn_dep_tree() {
	mvn dependency:tree
}

mvn_effective_pom() {
	mvn help:effective-pom
}

# Deletes all dependencies from the local repository ~/.m2 that haven't be accessed in a while.
mvn_purge_local_repository() {
	:
}