#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'themes'
fi

function themes() {
    open $HOME/.pulsebridge/prompt/themes/terminal/Monokai.terminal
}