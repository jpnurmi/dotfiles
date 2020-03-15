#!/bin/bash

if [ $# == 0 ]; then
    echo -e "Setup: $(find ~/.setup -name '*.sh' | xargs -L1 -I{} basename '{}' .sh | sort | paste -sd ' ')"
else
    sh=~/.setup/${1}.sh
    if [ ! -f "$sh" ]; then
        echo "ERROR: cannot find $sh"
        exit 1
    fi
    . $sh
fi
