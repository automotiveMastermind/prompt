#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'set-nvm'
fi

function set-nvm()
{
    nvm_path=$(brew --prefix nvm)

    if test -d $nvm_path; then
        if ! test -d $HOME/.nvm; then
            mkdir -p $HOME/.nvm
        fi

        export NVM_DIR=$HOME/.nvm

        source $nvm_path/nvm.sh
    fi

    nvm use --lts
}

set-nvm