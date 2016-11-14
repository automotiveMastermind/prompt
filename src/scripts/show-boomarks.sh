#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'show-bookmarks'
fi

function show-bookmarks() {
    cat $HOME/.uber/scripts/bookmarks.sh
}

function lbm() {
    show-bookmarks
}

function lb() {
    show-bookmarks
}