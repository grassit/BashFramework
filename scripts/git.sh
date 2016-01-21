
# Running this will cause the credentials used to push or pull from server to be cached, and you won't be asked again
alias cache_git_credentials="git config credential.helper store"

# TODO: make it emulate functionality of svn diff-all-rev...
# Define it to consider file movements to different directory 
git_diff_all_file_revisions() {
	:
}

# Automatically commits current directory
auto_commit() {
    git add --all
    git commit -m 'auto commit'
}

# Automatically pushes current directory to remote server
auto_push() {
	auto_commit
	git config credential.helper store
	git push
}

git_gen_ignore_file() {
echo "$(cat <<-EOF
*/target/**
target/**
*.log
*.log.*
*.iml
.idea
.svn
EOF
)" > .gitignore
}

# Fetches latest svn commits for repos in all subdirectories
# TODO: test if working
git_svn_fetch_all() {
	repos=`find . -name '.git'`
	echo $repos
	for i in "$repos"
    do
    	dir=`pwd`
    	cd `dirname $i`
    	echo "cd `dirname $i`"
        git svn fetch
        echo "--------------------"
        cd $dir
    done
}

# TODO: how to search for a term in all revisions of a file not just current version
# TODO: search for first occurence of given term in history of a file


#giggle
#git-cola
#giteye
#gitg
#gitk





