# Subversion
alias st='svn st --ignore-externals'
alias stnoex='st | grep -v "X"'

# Git
alias gst="git status"
alias gru="git remote update"
alias git-list="git status --porcelain --untracked-files=no | cut -c4- | tr '\n' ' '"

# VIM
alias resume-vim="vim -p -- $(git-list)"
alias vim="vim -c NERDTreeToggle"
alias evim="sudo vim -O /etc/vimrc ~/.vimrc"

# PHP
alias php="php -dzend_extension=xdebug.so"
alias console="sudo -u www-data php bin/console"
alias composer5.5="php5 /usr/local/bin/composer"
alias composer7.0="php7.0 /usr/local/bin/composer"
alias composer7.1="php7.1 /usr/local/bin/composer"

alias ebash="sudo vim -O ~/.bashrc ~/my.environment/bash/aliases.bash ~/my.environment/bash/functions.bash"

# Dirs
alias webroot="cd $(pwd | cut -d'/' -f -4)"
alias modown-dir="sudo chown www-data:www-data -R .; sudo chmod g+w -R ."

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'


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

alias php='\
    docker run --rm --interactive --tty \
        --volume $PWD:/app \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        php:7.2 php \
'
alias composer='\
    docker run --rm --interactive --tty \
        --memory="4g" \
        --memory-swap="1g" \
        --volume $PWD:/app \
        --volume $COMPOSER_HOME:/tmp \
        --volume /tmp/cache/composer:/tmp/cache \
        --volume ~/.ssh:/root/.ssh \
        composer /usr/local/bin/php -d memory_limit=-1 /usr/bin/composer   \
'
alias npm='\
    docker run -it --rm \
        --volume `pwd`:/home/node/app \
        -w /home/node/app \
        node:8.15-alpine npm \
'
#        --user $(id -u):$(id -g) \
#        --volume /etc/passwd:/etc/passwd:ro \
#        --volume /etc/group:/etc/group:ro \
