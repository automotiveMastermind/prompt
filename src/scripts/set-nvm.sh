#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'set-nvm'
fi

__prompt-set-nvm()
{
    local NVM_PATH=$(which nvm)

    if [ -z ${NVM_PATH+x} ]; then
        nvm use --lts --delete-prefix
        eval "$(npm completion)"
        return
    fi

    NVM_PATH=$(brew --prefix nvm 2>/dev/null)

    if [ -z ${NVM_PATH+x} ]; then
        NVM_PATH=$HOME/.nvm
    fi

    if [ ! -d ${NVM_PATH} ]; then
        echo "not found"
        return
    fi

    source "$NVM_PATH/nvm.sh"
    nvm use --lts --delete-prefix
    eval "$(npm completion)"
}