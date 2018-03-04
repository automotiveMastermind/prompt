#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'add-bookmark'
fi

add-bookmark-usage() {
    echo 'add-bookmark <name>'
    echo '     name : a name for your bookmark'
}

add-bookmark() {
    # make sure that a bookmark was specified.
    if [ -z ${1+x} ]; then
        echo 'add-bookmark: missing <name>'
        add-bookmark-usage
        return
    fi

    # make sure we remove any existing bookmark before defining another one.
    remove-bookmark $1 silent
    local BOOKMARK="$1"=\"$(pwd)\"

    echo "add-bookmark: adding bookmark $BOOKMARK"
    echo $BOOKMARK >> $HOME/.am/prompt/scripts/bookmarks.sh
    source $HOME/.am/prompt/scripts/bookmarks.sh
}