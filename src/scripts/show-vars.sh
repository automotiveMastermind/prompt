#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-vars'
fi

function show-vars() {
    cat $HOME/.am/prompt/scripts/variables.sh 2>/dev/null
}