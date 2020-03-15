#!/bin/sh

echo "Setting up Qt Creator..."

if [ ! -d $PROJECT_DIR/qt-creator ]; then
    git -C $PROJECT_DIR clone --recurse-submodules git://code.qt.io/qt-creator/qt-creator.git
fi
