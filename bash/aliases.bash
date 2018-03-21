# Subversion
alias st='svn st --ignore-externals'
alias stnoex='st | grep -v "X"'

# Git
alias gst="git status"
alias gru="git remote update"

alias ebash="sudo vim ~/.bashrc"
alias evim="sudo vim /etc/vimrc"
alias composer="php5 /usr/local/bin/composer"
alias composer5.5="php5 /usr/local/bin/composer"
alias composer7.0="php7.0 /usr/local/bin/composer"
alias composer7.1="php7.1 /usr/local/bin/composer"

# [2011-05-13 17:05 EDT][tom@tom-laptop my.environment]$
STARTBLUE='\e[0;34m';
ENDBLUE="\e[0m"
STARTGREEN='\e[0;32m';
ENDGREEN="\e[0m"
#export PS1="$STARTCOLOR\u@\h \w> $ENDCOLOR"
#export PS1="[\$(date '+%Y-%M-%d %H:%M %Z')][$STARTGREEN\u$ENDGREEN@$STARTBLUE\h$ENDBLUE \W]\$ "
export PS1="[\$(date '+%Y-%M-%d %H:%M %Z')][\u@\h \W]\$ "
export PS1="\
\[\e[1;34m\]\
[\
\$(date '+%m-%d') \[\e[1;35m\]\$(date '+%H:%M %Z')\[\e[1;34m\]\
]\
 \u@\h \[\e[0;96m\]\W\[\e[93m\]\$(parse_git_branch)►\[\e[0m\] "
