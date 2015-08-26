# This file contains functions for managing directory bookmarks, they make directories easier to navigate to.
# You could save dirs commonly visited/currently needed for workflow and then open them easily.
# Reduces need for cd ls cd ls chores.

## TODO: need to save this permanently in a file. So that these bookmarks could be like bookmarks you use in nautilus in left navigation pane

# save present directory to directory bookmarks list
s() {
bookmarks=("${bookmarks[@]}" "`pwd`")
export bookmarks
}

# list directory book marks
bm() {
index=1
for b in ${bookmarks[@]}; do
    echo $index.    $b
    index=$(($index+1))
done
}

v() {
index=$(($1-1)) 
cd ${bookmarks[$index]}
}

# Bookmarks clear
bmc(){
unset bookmarks
}

# Enhances the builtin cd by saving history everytime you switch directory. Having history would allow us to define functions that allow us to go back

# Gave up. Not working. Need to find a way to override the builtin command
#cd() {
#_history=(i"${_history[@]}" "`pwd`")
#export _history
#echo $_history
#echo blah blah
#builtin cd $1
#}
