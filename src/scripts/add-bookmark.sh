#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'add-bookmark'
fi

function add-bookmark() {
    # make sure that a bookmark was specified.
    if [ -z "${1:-}" ]; then
        echo USAGE: add-bookmark NAME
        echo '      NAME : a title for your bookmark'
    else
        # make sure we remove any existing bookmark before defining another one.
        remove-bookmark $1 silent
        local b="$1"=\"$(pwd)\"

        echo Adding bookmark: $b
        echo $b >> $HOME/.pulsebridge/prompt/scripts/bookmarks.sh
        source $HOME/.pulsebridge/prompt/scripts/bookmarks.sh
    fi
}

function mbm() {
    add-bookmark $@
}

function mb() {
    add-bookmark $@
}