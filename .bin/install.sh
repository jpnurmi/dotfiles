#!/bin/bash

git clone --bare git@github.com:jpnurmi/dotfiles.git ~/.dotfiles

if [ $? != 0 ]; then
    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ""
    fi
    echo "Upload SSH key:"
    cat ~/.ssh/id_rsa.pub
    exit
fi

function config {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

config checkout

if [ $? != 0 ]; then
    echo "Backing up existing dot files..."
    mkdir ~/.dotfiles.bak
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.dotfiles.bak/{}
    config checkout
fi

config config status.showUntrackedFiles no
