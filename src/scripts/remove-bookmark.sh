#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'remove-bookmark'
fi

remove-bookmark() {
    local b=$1
    local r=
    local scripts_path=$HOME/.uber/scripts

    if ! test -z "$b"; then
        r=$(command grep -s -m 1 ^$b $scripts_path/bookmarks.sh)
    elif test -z "$2"; then
        r=$(command grep -s -m 1 \"$PWD\"$ $scripts_path/bookmarks.sh)
    fi

    if ! test -z "$r"; then
        test -z "$2" && ( echo Removing bookmark: $r )

        command grep -s -v $r $scripts_path/bookmarks.sh >> $scripts_path/bookmarks1.sh
        mv -f $scripts_path/bookmarks1.sh $scripts_path/bookmarks.sh

        source $scripts_path/bookmarks.sh
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