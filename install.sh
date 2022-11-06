#!/bin/bash

pwd=$(pwd)

if [ $SHELL = "/usr/bin/zsh" ]
then
    file="$HOME/.zshrc"
elif [ $SHELL = "/usr/bin/bash" ]
then
    file="$HOME/.bashrc"
fi

chmod u+x ltx.sh

echo "alias ltx=\"$pwd/ltx.sh\"" >> $file
