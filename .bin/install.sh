#!/bin/bash

function config {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

if [ ! -d ~/.dotfiles ]; then
    echo "Cloning config..."
    git clone --bare git@github.com:jpnurmi/dotfiles.git ~/.dotfiles > /dev/null

    if [ $? != 0 ]; then
        if [ ! -f ~/.ssh/id_rsa ]; then
            ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ""
        fi
        echo "Upload SSH key:"
        cat ~/.ssh/id_rsa.pub
        exit
    fi
else
    echo "Updating config..."
    config fetch > /dev/null 2>&1
fi

echo "Checking out config..."
config checkout > /dev/null 2>&1

if [ $? != 0 ]; then
    echo "Backing up config..."
    [ -d ~/.dotfiles.bak ] || mkdir ~/.dotfiles.bak
    function mkv {
        [ -d $(dirname $2) ] || mkdir -p $(dirname $2)
        mv $1 $2
    }
    for f in $(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'}); do
        mkv $f ~/.dotfiles.bak/$f
    done
    config checkout > /dev/null 2>&1
fi

config config status.showUntrackedFiles no
