#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'themes'
fi

function themes() {
    open $HOME/.pulsebridge/prompt/themes/terminal/Monokai.terminal
}