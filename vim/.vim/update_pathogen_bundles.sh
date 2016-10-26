#!/bin/bash

echo "    ";
pushd /home/ctatro/.vim/bundle;

for dir in $(ls -d -1 ./*); do

echo "                         ";
echo "-------------------------";
    pushd $dir > /dev/null;
     echo "|  ${PWD##*/}" | tr "[:lower:]" "[:upper:]"
echo "----- URL ---------------";
git config --get remote.origin.url >> ~/.vim/plugins-used.txt
git config --get remote.origin.url
echo "-------------------------";

    git remote update;
    echo "Pulling changes"
    git pull > /dev/null;
    popd > /dev/null;
echo "                         ";
done;

popd;
