#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-bookmarks'
fi

function show-bookmarks() {
    cat $HOME/.pulsebridge/prompt/scripts/bookmarks.sh 2>/dev/null
}

function lbm() {
    show-bookmarks
}

function lb() {
    show-bookmarks
}