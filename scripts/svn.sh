######################
## The functions defined here are useful when you're starting on a new project.
## You won't know the history of project, what changes were made by whom and when.
## In this case these functions help you search the history instead of manually checking out and comparing different versions.
#####################

# Default path used if none specified when invoking following functions.
svnpath=""

# Default number of days for fetching history
days=""

# TODO: modify each function name so that it starts with svn_

# why this function? Following command returns output like this:
# svn log svn://57.5.179.19/revenue-integrity | grep RAI-417
# Output: "RAI-417 : Update accepted ticketing types to exclude TKNM and TKNA (delete ITC test)"
# I.e. only the particular line is returned whereas we want a few lines from above and below to have some context such as date and person.
# Define this function to search in svn log with proper output
function search_in_comments() {
    :
}

function svn_set_path() {
    svnpath="$1"
}

# Outputs the full history of a given file as a sequence of
# logentry/diff pairs.  The first revision of the file is emitted as
# full text since there's not previous version to compare it to.
# Usage: diff_all_revisions file_path
# TODO: replace this function with a parameterized version of diff_file_revisions
# TODO: add functionality to specify file by name or pattern. There are multiple files with that name it could show list and ask for 
# option 1 or 2
function diff_all_file_revisions() {
    url=$1
    revisions=`svn log -q $url | grep -E -e "^r[[:digit:]]+" -o | cut -c 2- | sort -nr` # Find all revisions of the file
    revisions=($revisions) # Convert to array

    # Head revision as full text
    svn cat -r${revisions[0]} $url

    # Rest of revisions as difference
    arr_len=${#revisions[@]}
    for ((index=0; index < $(($arr_len-1)); index++)); do
        svn log -r ${revisions[index]} $url
        svn diff -r ${revisions[index+1]}:${revisions[index]} $url        
    done

    # Last revision as full text
    svn log -r ${revisions[arr_len-1]} $url
    svn cat -r${revisions[arr_len-1]} $url
}

# Dumps the full history of all files under a given path as diff.
function get_diff_for_all_subpaths() {
    path=$1
    files=$(__svn_ls_all $path)
    for file in $files; do        
        dir_name=`dirname $(str_delete_all $file $path\/)` # Find relative directory name
        `mkdir -p $dir_name` # Create directory
        file_name=`basename $file` # Find file name
        
        # Find diff and save as file
        echo `dir_concat $dir_name $file_name`
        $(diff_all_file_revisions $file > `dir_concat $dir_name $file_name`)        
    done
}

# Similar to diff_all_revisions except it diffs given revisions. Required revisions specified by revision number range
# Usage: diff_revisions file_path_in_svn rev1 rev2
# Example: 
# TODO: modify the function to use a default of 1 year if none specified, create another funtion that provides revision number for a given date
# TODO: i'm having to do tee manually every time have an option to do this in function, use a flag
diff_file_revisions() {
    url=$1
    revisions=($(svn log -q $url | grep -E -e "^r[[:digit:]]+" -o | cut -c 2- | sort -nr))
    rev1=$2
    for rev in ${revisions[@]}; do
        rev=${rev#r}
        if (( rev > rev1 )); then
            echo
            svn log -r$rev $url@HEAD
            svn diff -c$rev $url@HEAD
            echo
        fi
    done
}

# Gets all the revisions of a file from history
# The files gets saved as file.rev1.ext file.rev2.ext etc in the current folder
# TODO: include date in the filename or provide an option to append the svn log description 
# TODO: instead of get_all make it get with parameters
get_all_file_revisions() {
    revs=($(get_revision_numbers $1))
    name=$(file_base_name $1)
    ext=$(file_ext $1)

    for r in ${revs[@]}; do
        svn cat $1@$r > $name.$r.$ext
    done
}

# Similar to diff_all_revisions except it diffs given revisions. Required revisions specified by date. Provide convenience flags to specify date by -1 month, -1 week which you mean in last month and last week.
diff_date_revisions() {
    :
}

# TODO: HOW ABOUT a web interface that shows you the list of files that were modified and when you click a file a full diff of that file.
# Or instead of a web interface which would require too much effort and effort irrelevant to purpose at hand (like tweaking CSS of page) we 
# could create a function build_history() which takes a SVN url and builds history for each element. Then it downloads the complete diff for
# each file with the .Filename.java approach.

# Lists all the files committed as part of a revision
# Usage: list_files_for_revision revision-number
list_files_for_revision() {
    svn log --verbose -r $1
}

# Lists all revision numbers for a file
# TODO parameterize this away
get_all_revision_numbers() {
    for rev in `svn log -l 1000 $1 | grep ^r[0-9] | cut -c 2- | cut -d ' ' -f 1`; do
        echo $rev
    done
}

# Gets the revision numbers between two dates
get_revision_numbers() {
    :
}

get_revision_numbers_with_dates() {
    for rev in `svn log -l 1000 $1 | grep ^r[0-9] | cut -c 2- | cut -d ' ' -f 1,5,6`; do
        echo $rev
    done
}

# Find a given file by name
# Find a given directory by name, advantage over svn log | grep, is that it does not show subdirectories. 
# For example: it would not show trunk/ trunk/config trunk/config/abc. It would just say trunk.
svnfind() {
    :
}


#TODO: Understand how this loop can be piped to a command. In bash is anything echoed in a loop considered output of that loop?
#
#arr2=( $(
#    for el in "${arr[@]}"
#    do
#        echo "$el"
#    done | sort) )

#TODO: this function saves a path (file or dir) to local without checking out
# This can be accomplised using ls for dir and cat for files.
svn_save() {
    :
}

#TODO instead of specifying the path and revision numbers with every command should we provide a function called setpath(svnpath).
# Or have the user define these variables like: upper_rev=98, lower_rev=12. svnpath="". We provide a function xxx() that displays these
# current settings.
# These get set in the variables local to that shell session and then used everytime a function is called.

svn_grep() {
    :
}

# Greps all revisions of all files in given path. Gives list of files and the revisions in which the text occurs.
# Very slow but replaces manual effort.
# Downloads the files to tmp location to do the grep. Prints out the location of the files so that user could visit and analyze in more detail
svn_grep_all_rev() {
    :
}

# Function to clone a svn path with all its history
# Usage: svn_to_git date1 date2 svn-path
svn_to_git() {
    :
}

# Function to walk through a path and clone the directories which match a given name. 
# For example, to clone only trunks while leaving out tags and branches you could say:
# svn_to_git_selective date1 date2 svn-path pattern
# svn_to_git_selective 2014-06-15 2015-06-15 svn://57.5.179.19/revenue-integrity/ trunk
svn_to_git_selective() {
    :
}

# Function to selectively checkout directories that match a certain name. For example, to checkout all the trunks of multiple projects leaving out tags.
svn_selective_checkout() {
    :
}

# Updates all repositories in any of the subdirectories. 
# Usage: svn_update_all
svn_update_all() {
    # Find all svn repositories in subdirectories
    repos=`find . -name '.svn'`

    # TODO: print number of repositories found and being updated

    # Update each repo
    for i in "$repos"
    do
        svn update `dirname $i`
        echo
        #TODO: print line of - to seperate each update output from other
    done
}

# Replicates the directory structure at given svn path recursively
# TODO: broken, does not work
__svn_replicate_dirs() {
    dir_list=(`__svn_ls_dir $1`)
    files=(`__svn_ls_files $1`)

    for f in ${files[@]}; do
        echo "bum" > $f
    done

    for l in ${dir_list[@]}; do
        mkdir $l
        cd $l
        `__svn_replicate_dirs $1/$l`
        cd ..
    done
}

# Returns directories at given svn path
__svn_ls_dir() {
    list=($(svn ls $1))
    dir_list=$(retain_all /$ ${list[@]})
    echo ${dir_list[@]}
}
# Returns files at given svn path
__svn_ls_files() {
    list=($(svn ls $1))
    files=$(remove_all /$ ${list[@]})
    echo ${files[@]}
}

# Returns list of all subpaths under given path
__svn_ls_all() {
    local path=$1
    list=($(svn ls $path))
    files=$(remove_all /$ ${list[@]})

    for file in $files; do
        echo $path/$file
    done
    
    dir_list=$(retain_all /$ ${list[@]})

    for dir in $dir_list; do
        __svn_ls_all $path/$dir
    done
}

# Show list of persons responsible for this file.
# Author: ksharma 19 June 2013
# Others: asharma, bsharma
svn_blame() {
    :
}