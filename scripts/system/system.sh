# TODO: system.sh is too generic. Split or rename it to be more specific. For example: package-manager.sh, etc

## Improvisations/redefinitions of system utilities

alias grep="grep --color=auto"

# Lists the files that were modified by the given installed package
list_package_files() {
	files=($(dpkg -L $1))
	for f in ${files[@]}; do
		if [[ -f $f ]]; then
			echo $f
		fi
	done
}

# Lists the directories that were modified by the given installed package
list_package_dirs() {
	files=($(dpkg -L $1))
	for f in ${files[@]}; do
		if [[ -d $f ]]; then
			echo $f
		fi
	done
}

#TODO function that takes multiple files. Say 5. Prints unified diff of 1 and 2, 2and 3, 3 and 4, ...
# Kind of like the SVN diff command
diff_multiple() {
	:
}

# TODO: convert this into a generic function whereby a warning is emitted if long form is used instead of alias
# Also move this to a different file like system_alias.sh or something
# This could be done by making a hasmap of commands to their short forms and having a generic function check this map
gnome-system-monitor() {
	info "Use alias gsm instead of full name."
}

gsm() {
	/usr/bin/gnome-system-monitor gnome-system-monitor >/dev/null 2>&1 & disown
}

# Function to kill all processes whose process description contains a given word
kill_all() {
    pids=$(ps -eo pid,cmd | grep $1 | grep -v grep | sed -n 's/.*\(^.[0-9]*\).*/\1/p')

    for p in ${pids}; do
        info "Killing PID: $p"
        $(kill -9 $p)
    done
}

# Recursive grep for given text in filenames that match a pattern
grep_files() {
    text="$1"
    filename_pattern="$2"
    grep -r "$text" --include "$filename_pattern"
}

# List loc for subdirectories separately
rcloc() {
    # maxdepth1 to stay in current dir only, and avoid deeply nested dirs
    _dirs=$(find $1 -maxdepth 1 -type d)
    for d in $_dirs; do
        info "############$d###########"
        cloc $d
    done
}