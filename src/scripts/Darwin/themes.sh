#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'themes'
fi

themes() {
    open $HOME/.am/prompt/themes/terminal/Monokai.terminal
}

theme() {
    themes
}