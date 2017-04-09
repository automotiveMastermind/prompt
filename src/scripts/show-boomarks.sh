#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-bookmarks'
fi

show-bookmarks() {
    cat $HOME/.am/prompt/scripts/bookmarks.sh 2>/dev/null
}

lbm() {
    show-bookmarks
}

lb() {
    show-bookmarks
}