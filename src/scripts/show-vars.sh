#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-vars'
fi

show-vars() {
    local varpath="$HOME/.am/prompt/user/variables.sh"

    if [ ! -f $varpath ]; then
        echo 'show-vars: no variables are currently specified'
        add-var-usage
        return
    fi

    cat $varpath
}

vars() {
    show-vars
}