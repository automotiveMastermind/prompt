#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'clear-screen'
fi

function cls() {
    clear
}