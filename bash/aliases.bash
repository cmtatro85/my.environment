alias vim='vim -c VSTreeExplore'

# Subversion
alias st='svn st --ignore-externals'
alias svnUp='svn up --ignore-externals'

# Git
alias gst="git status"
alias gru="git remote update"

alias ebash="sudo vim ~/.bashrc"
alias evim="sudo vim /etc/vimrc"

# [2011-05-13 17:05 EDT][tom@tom-laptop my.environment]$
STARTBLUE='\e[0;34m';
ENDBLUE="\e[0m"
STARTGREEN='\e[0;32m';
ENDGREEN="\e[0m"
#export PS1="$STARTCOLOR\u@\h \w> $ENDCOLOR"
export PS1="[\$(date '+%Y-%M-%d %H:%M %Z')][$STARTGREEN\u$ENDGREEN@$STARTBLUE\h$ENDBLUE \W]\$ "
