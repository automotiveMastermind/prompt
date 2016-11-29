#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'clear-screen'
fi

function cls() {
    clear
}