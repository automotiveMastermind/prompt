#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'show-bookmarks'
fi

function show-bookmarks() {
    cat $HOME/.pulsebridge/prompt/scripts/bookmarks.sh
}

function lbm() {
    show-bookmarks
}

function lb() {
    show-bookmarks
}