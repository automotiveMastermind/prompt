#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'remove-bookmark'
fi

remove-bookmark-usage() {
    echo 'remove-bookmark <name>'
    echo '     name  : the name or path of your bookmark'
}

remove-bookmark() {
    local bookmark=$1
    local userpath="$AM_HOME/user"

    if [ -z "${bookmark:-}" ]; then
        remove-var-usage
        return 1
    fi

    local row=$(grep -s -m 1 ^$bookmark "$userpath/bookmarks.sh")

    if [ -z "${row:-}" ]; then
        local row=$(grep -s -m 1 $bookmark$ "$userpath/bookmarks.sh")
    fi

    if [ -z "${row:-}" ]; then
        local row=$(grep -s -m 1 $path$ "$userpath/bookmarks.sh")
    else
        local row=$(grep -s -m 1 \"$PWD\"$ "$userpath/bookmarks.sh")
    fi

    if [ -z "${row:-}" ]; then
        echo 'remove-bookmark: no bookmark was found for the specified title or path.'

        return 1
    fi

    "remove-bookmark: removing bookmark $row"

    grep -s -v $r "$userpath/bookmarks.sh" >> "$userpath/bookmarks1.sh"
    mv -f "$userpath/bookmarks1.sh" "$userpath/bookmarks.sh"

    source $userpath/bookmarks.sh
}