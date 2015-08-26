
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
#giggle
#git-cola
#giteye
#gitg
#gitk





