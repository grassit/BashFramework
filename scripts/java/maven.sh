
# Expands to arguments required to run maven without tests #
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
LOCAL_REPO="/home/$USER/.m2/repository"
TIME="1440" #2 months
mvn_purge_local_repo() {
	echo "Size before purge: `_du $LOCAL_REPO -sh`"
	find $LOCAL_REPO -atime +$TIME -exec rm -rf {} \;
	find $LOCAL_REPO -type d -empty -exec rm -rf {} \;
	echo "Size after purge: `_du $LOCAL_REPO -sh`"
}

# Shows the old files in repository
mvn_show_old_files() {
	find $LOCAL_REPO -atime +$TIME
}