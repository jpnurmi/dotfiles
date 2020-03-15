#!/bin/bash

echo "Setting up Communi..."

if [ ! -d $PROJECT_DIR/libcommuni ]; then
    git clone --recurse-submodules git://github.com/communi/libcommuni.git $PROJECT_DIR/libcommuni
    git -C $PROJECT_DIR/libcommuni remote set-url origin git@github.com:communi/libcommuni.git
    git -C $PROJECT_DIR/libcommuni remote add jpnurmi git@github.com:jpnurmi/libcommuni.git
fi

if [ ! -d $PROJECT_DIR/communi ]; then
    git clone --recurse-submodules git://github.com/communi/communi-desktop.git $PROJECT_DIR/communi
    git -C $PROJECT_DIR/communi remote set-url origin git@github.com:communi/communi-desktop.git
    git -C $PROJECT_DIR/communi remote add jpnurmi git@github.com:jpnurmi/communi-desktop.git
fi
