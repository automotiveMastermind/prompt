#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'set-nvm'
fi

__prompt-set-nvm()
{
    if type brew 1>/dev/null 2>&1; then
        local nvm_path=$(brew --prefix nvm)
    else
        local nvm_path=$(which nvm)
    fi

    if [ -d $nvm_path ]; then
        if [ ! -d "$HOME/.nvm" ]; then
            mkdir -p "$HOME/.nvm"
        fi

        export NVM_DIR="$HOME/.nvm"

        source "$nvm_path/nvm.sh"
    fi

    nvm use --lts
}