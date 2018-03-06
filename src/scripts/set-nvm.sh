#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'set-nvm'
fi

__prompt-set-nvm()
{
    NVM_PATH=$(brew --prefix nvm 2>/dev/null)

    if [ -z ${NVM_PATH+x} ]; then
        NVM_PATH=$HOME/.nvm
    fi

    if [ ! -d ${NVM_PATH} ]; then
        echo "not found"
        return
    fi

    if [ -f "$NVM_PATH/nvm.sh" ]; then
        export NVM_DIR="${HOME}/.nvm"
        source "$NVM_PATH/nvm.sh"
        eval "$(npm completion)"
    fi
}