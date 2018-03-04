#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'remove-bookmark'
fi

remove-bookmark-usage() {
    echo 'remove-bookmark <name>'
    echo '     name  : the name or path of your bookmark'
}

remove-bookmark() {
    local BOOKMARK=$1
    local USER_PATH="$AM_HOME/user"
    local ROW=

    if [ -z "${BOOKMARK:-}" ]; then
        remove-var-usage
        return 1
    fi

    ROW=$(grep -s -m 1 ^$BOOKMARK "$USER_PATH/bookmarks.sh")

    if [ -z "${row:-}" ]; then
        ROW=$(grep -s -m 1 $BOOKMARK$ "$USER_PATH/bookmarks.sh")
    fi

    if [ -z "${row:-}" ]; then
        ROW=$(grep -s -m 1 $path$ "$USER_PATH/bookmarks.sh")
    else
        ROW=$(grep -s -m 1 \"$PWD\"$ "$USER_PATH/bookmarks.sh")
    fi

    if [ -z ${ROW+x} ]; then
        echo 'remove-bookmark: no bookmark was found for the specified title or path.'

        return 1
    fi

    "remove-bookmark: removing bookmark $ROW"

    grep -s -v $r "$USER_PATH/bookmarks.sh" >> "$USER_PATH/bookmarks1.sh"
    mv -f "$USER_PATH/bookmarks1.sh" "$USER_PATH/bookmarks.sh"

    source $USER_PATH/bookmarks.sh
}