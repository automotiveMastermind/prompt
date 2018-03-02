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

    if [ ! -d ${nvm_path:-/__no__exist} ]; then
        if [ ! -d "$HOME/.nvm" ]; then
            mkdir -p "$HOME/.nvm"
        fi

        nvm_path="$HOME/.nvm"
        export NVM_DIR=$nvm_path
        source "$NVM_DIR/nvm.sh"
    fi

    nvm use --lts --delete-prefix
    eval "$(npm completion)"
}