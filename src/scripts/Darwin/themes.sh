#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'themes'
fi

function themes() {
    open $HOME/.uber/themes/terminal/Monokai.terminal
}