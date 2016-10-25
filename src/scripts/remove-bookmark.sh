#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'remove-bookmark'
fi

remove-bookmark() {
    local b=$1
    local r=

    if ! test -z "$b"; then
        r=$(command grep -s -m 1 ^$b ~/.ssh/scripts/bookmarks.sh)
    elif test -z "$2"; then
        r=$(command grep -s -m 1 \"$PWD\"$ ~/.ssh/scripts/bookmarks.sh)
    fi

    if ! test -z "$r"; then
        test -z "$2" && ( echo Removing bookmark: $r )

        command grep -s -v $r ~/.ssh/scripts/bookmarks.sh >> ~/.ssh/scripts/bookmarks1.sh
        mv -f ~/.ssh/scripts/bookmarks1.sh ~/.ssh/scripts/bookmarks.sh

        source ~/.ssh/scripts/bookmarks.sh
    else
        test -z "$2" && ( echo No bookmark was declared for the specified title or address. )
    fi
}

function rbm() {
    remove-bookmark $@
}

function rb() {
    remove-bookmark $@
}