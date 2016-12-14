#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-bookmark'
fi

remove-bookmark() {
    local b=$1
    local r=
    local scripts_path=$HOME/.pulsebridge/prompt/scripts

    if [ ! -z "${b:-}" ]; then
        r=$(grep -s -m 1 ^$b $scripts_path/bookmarks.sh)
    elif [ -z "${2:-}" ]; then
        r=$(grep -s -m 1 \"$PWD\"$ $scripts_path/bookmarks.sh)
    fi

    if [ ! -z "${r:-}" ]; then
        [ -z "${2:-}" ] && ( echo "Removing bookmark: $r" )

        grep -s -v $r $scripts_path/bookmarks.sh >> $scripts_path/bookmarks1.sh
        mv -f $scripts_path/bookmarks1.sh $scripts_path/bookmarks.sh

        . $scripts_path/bookmarks.sh
    elif [ -z "${2:-}" ]; then
        echo "No bookmark was declared for the specified title or address."
    fi
}

function rbm() {
    remove-bookmark $@
}

function rb() {
    remove-bookmark $@
}