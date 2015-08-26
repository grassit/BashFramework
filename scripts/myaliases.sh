#### General usability aliases
alias k='kill -9'
alias c='cd ..'
alias ls='ls -lth --color=auto'


### Java
alias p='ps -ef | grep catalina | grep -v grep'
alias tomcat_id="p | awk -F' ' '{print $2}'"

### Managing bash customizations
# TODO: convert to appropriate functions as with functions()
alias aliases="cat ~/.bash/scripts/myaliases.sh"
alias editaliases="vi ~/.bash/scripts/myaliases.sh"
alias editpaths="vi ~/.bash/profile.sh"
