
# Running this will cause the credentials used to push or pull from server to be cached, and you won't be asked again
alias git_cache_credentials="git config credential.helper store"

# Git log
##########
alias gitl='git log --name-only --graph --all' # Git log
alias gitls='git log --pretty=format:"%ad %Cblue[%an]%Creset %C(red bold)%s%d%Creset %h" --date=short' # Git simple log
alias gitlsn='git log --pretty=format:"%ad %Cblue[%an]%Creset %C(red bold)%s%d%Creset %h" --date=short -n 10' # Git simple log, last 10 lines
alias gitla='git log --pretty=format:"%ad %Cblue[%an]" --date=short' # Git authors log
alias gitlc='git log --pretty=format:"%ad %C(red bold)%s%d" --date=short' # Git comment log
##########

#TODO: git function to check if we're in sync with the remote repo. i.e. if our head is at the top. i.e. do we need to rebase?
# Output: "You are 3 commits behind from remote"
git_is_in_sync() {
    :
}

# Reverts changes to a file given by name
git_revert() {
    # To do this, just Checkout the file again by using absolute path
    # e.g. git checkout HEAD path/to/file
    :
}

git_setup_aliases() {
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
}

# TODO: make it emulate functionality of svn diff-all-rev...
# Define it to consider file movements to different directory 
git_diff_all_file_revisions() {
	:
}

# Automatically commits current directory
git_auto_commit() {
    git add --all
    git commit -m 'auto commit'
}

# Automatically pushes current directory to remote server
git_auto_push() {
	auto_commit
	git config credential.helper store
	git push
}

# Places an ignore file in all git repositories in subdirectories
git_gen_ignore_file_all() {
    :
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
.pyc
.class
EOF
)" > .gitignore
}

# Fetches latest svn commits for repos in all subdirectories
git_svn_fetch_all() {
	repos=(`find . -name '.git'`)
    echo "Found ${#repos[@]} git repositories."
    echo

	for i in "${repos[@]}"
    do  
        echo "Updating `dirname $i`"
        (cd `dirname $i` && git svn fetch)
        echo "--------------------"    
    done
}

# TODO: Shows list of projects that've been committed to yesterday
git_find_active_yesterday() {
    :
}

git_find_active_last_week() {
    :
}

#Not active for a week
git_find_dormant() {
    :
}

# 

# TODO: how to search for a term in all revisions of a file not just current version
# TODO: search for first occurence of given term in history of a file


# TODO: move these guis to command guide and not here
#giggle
#git-cola
#giteye
#gitg
#gitk




# TODO: What does this function do? Does it work?
git_find_by_name() {
    tmpdir=$(mktemp -td git-find.XXXX)
    trap "rm -r $tmpdir" EXIT INT TERM

    allrevs=$(git rev-list --all)
    # well, nearly all revs, we could still check the log if we have
    # dangling commits and we could include the index to be perfect...

    for rev in $allrevs
    do
      git ls-tree --full-tree -r $rev >$tmpdir/$rev 
    done

    cd $tmpdir
    grep $1 * 
}
