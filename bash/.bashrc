# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1="[\$(date '+%H:%M %Z')][\u@\h \W]\$  "
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in (xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
esac

PROMPT_COMMAND='echo -en "\033]0; ${HOSTNAME} : ${PWD} [[ `date` ]]\007"'


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias gtags="git tags -l | sort -V"
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias test_w_phpunit="./vendor/bin/phpunit ./tests"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias vim="vim -c NERDTreeToggle"
alias git-list="git status --porcelain | cut -c4-"
alias resume-vim="vim -p git-list"
alias lroot-mysql="mysql -u root -p --host devdb1"
alias webroot="cd $(pwd | cut -d'/' -f -4)"
alias putest="pushd `pwd | cut -d'/' -f -4 `; phpunit -c app vendor/imc; popd;"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias cclear="clear; tput cup 10 0"
alias testProjFromBundle="pushd; phpunit -c app ./vendor/imc/ ;pushd"

function unpushed_check() {
    echo '' > /tmp/unpushed;
    for file in $(ls -1); do
        conformed=$(sed -e 's/\(^\w\|-\w\)/-\U\1/g' -e 's/^-//' <<< $file | sed -e 's/--//g');
        lfile=$file/IMC/$conformed
        echo `find ./ -mindepth 3 -maxdepth 3 -iname "$conformed" -type d` >> /tmp/unpushed;
        echo ----------------------------------- >> /tmp/unpushed;
        p2Dir $lfile;
        if [ -n "$2" ] && [ $2 == 1 ]; then
          git remote update >> /dev/null;
        fi;
        git status >> /tmp/unpushed;
        echo "" >> /tmp/unpushed;
        echo "" >> /tmp/unpushed;
        popd >> /dev/null;
    done;

    if [ -n "$1" ] && [ $1 ==  1 ]; then
      cat /tmp/unpushed;
    else
      cat /tmp/unpushed | less
    fi;
    rm /tmp/unpushed;
}

function p2Dir() {
  files=( `find ./ -iregex ".*$1[a-zA-Z\-\_]*$" -type d`);
  count=${#files[@]}

  if [ $count == '0' ]; then
      echo no files found;
      return 1;
  fi;

  if [ $count == '1' ]; then
      pushd $files >> /dev/null;
      return 0;
  fi;

  echo "Lots oh files found:"
  for item in ${files[*]}
  do
      printf "   %s\n" $item
  done
}

function find-grep () {
 local FGRED=`echo "\033[31m"`
 local FGCYAN=`echo "\033[36m"`
 local BGRED=`echo "\033[41m"`
 local FGBLUE=`echo "\033[35m"`
 local NORMAL=`echo "\033[m"`

 # whether or not to only return defined functions
 local bool="$3"

 local files=( $(find ./ -type f -regex ".*$1.*" ) )
  if [[ $bool ]]
    then
      local search="public function $2"
  else
    local search=$2
  fi

  for ((i=0; i < ${#files[*]} ; i++))
  do
    declare rows=$(grep -in "$search" ${files[$i]})
    if [[ "$rows" ]]
      then
      echo "";
      echo ${files[$i]}
      grep -in "$search" ${files[$i]}
    fi

  done
}

# Source aliases.bash file from ~/my.environment/bash dir
. ~/my.environment/bash/aliases.bash
