#!/bin/sh

echo "Setting up Qt 5..."

if [ ! -d $PROJECT_DIR/qt5 ]; then
    git -C $PROJECT_DIR clone git://code.qt.io/qt/qt5.git
    cd $PROJECT_DIR/qt5 && ./init-repository -f --module-subset="default,-qtwebengine"
fi
