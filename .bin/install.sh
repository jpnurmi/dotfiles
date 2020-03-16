#!/bin/bash

if ! git lfs install; then
    echo "Install Git LFS"
    exit 1
fi

function config {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

if [ ! -d ~/.dotfiles ]; then
    echo "Cloning config..."
    git clone --bare git://github.com/jpnurmi/dotfiles.git ~/.dotfiles > /dev/null
    git -C ~/.dotfiles remote set-url origin git@github.com:jpnurmi/dotfiles.git
else
    echo "Updating config..."
    config fetch > /dev/null 2>&1
fi

if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ""
    echo "NOTE: upload SSH key:"
    cat ~/.ssh/id_rsa.pub
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

echo "Setting up config..."
config config status.showUntrackedFiles no
function bashrc_source {
    if [ ! -f ~/.bashrc ] || ! grep -Fxq "source ~/$1" ~/.bashrc; then
        echo "source ~/$1" >> ~/.bashrc
    fi
}
bashrc_source ".bash_functions"
bashrc_source ".bash_variables"

. ~/.bin/setup.sh
