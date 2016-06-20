# Git log
##########
alias gitl='git ' # Git log
alias gitlsn='git log --pretty=format:"%ad %Cblue[%an]%Creset %C(red bold)%s%d%Creset %h" --date=short -n 10' # Git simple log, last 10 lines
alias gitla='git ' # Git authors log
alias gitlc='git log --pretty=format:"%ad %C(red bold)%s%d" --date=short' # Git comment log
##########


only-hash() { 
    printf %s "--pretty=format:%h"
}