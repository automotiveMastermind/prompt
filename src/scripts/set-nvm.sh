#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'set-nvm'
fi

function set-nvm()
{
    if type brew 1>/dev/null 2>&1; then
        local nvm_path=$(brew --prefix nvm)
    else
        local nvm_path=$(which nvm)
    fi

    if [ -d $nvm_path ]; then
        if [ ! -d $HOME/.nvm ]; then
            mkdir -p $HOME/.nvm
        fi

        export NVM_DIR=$HOME/.nvm

        . $nvm_path/nvm.sh
    fi

    nvm use --lts
}

set-nvm