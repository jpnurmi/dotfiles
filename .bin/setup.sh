#!/bin/bash

if [ ! -z "$PROJECT_DIR" ] && [ ! -d "$PROJECT_DIR" ]; then
    mkdir $PROJECT_DIR
fi

if [ $# == 0 ]; then
    echo -e "Setup: $(find ~/.setup ~/.private -name '*.sh' | xargs -L1 -I{} basename '{}' .sh | sort | paste -sd ' ')"
else
    if [ -f ~/.setup/${1}.sh ]; then
        . ~/.setup/${1}.sh
    elif [ -f ~/.private/${1}.sh ]; then
        . ~/.private/${1}.sh
    else
        echo "ERROR: cannot find ${1}.sh"
        exit 1
    fi
fi
