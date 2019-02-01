# unpushed_check

# p2dir            Push dir to regex of dir.
    # args ["regex of dir"]

# find-grep        Locates functions within files
    # args ["regex", "string to search", "only functions"]

# fixSinceComment  Iterates through test and src to change docblock
    # args ["version number"]

# change-title     Changes the term title

# parse-git-branch Used for PS1

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

function fixSinceComment() {
    find ./src/ -name "*.php" -type f -exec sed -i "s/since  #.#.#/since  $1/g" {} +
    find ./tests/ -name "*.php" -type f -exec sed -i "s/since  #.#.#/since  $1/g" {} +
}

function change-title () {
   PROMPT_COMMAND='echo -ne "\033]0;$1 ${USER}@${HOSTNAME}: ${PWD}\007"'
}

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

function prettier-my-js () {
    FILES=$(git diff --cached --name-only --diff-filter=ACM "*.js" "*.jsx" | sed 's| |\\ |g')
    [ -z "$FILES" ] && echo 'no files found' && return 2

    # Prettify all selected files
    docker run -it --rm -v `pwd`:/home/node/app -w /home/node/app node:8.15-alpine ./node_modules/.bin/prettier --write $FILES
    unset FILES

    return 1
}
