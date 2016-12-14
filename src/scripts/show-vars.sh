#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-vars'
fi

function show-vars() {
    cat $HOME/.pulsebridge/prompt/scripts/variables.sh 2>/dev/null
}