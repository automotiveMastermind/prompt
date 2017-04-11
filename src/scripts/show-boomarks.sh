#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-bookmarks'
fi

show-bookmarks() {
    local bookmarkpath="$HOME/.am/prompt/user/bookmarks.sh"

    if [ ! -f $bookmarkpath ]; then
        echo 'show-bookmarks: no bookmarks are currently specified'
        add-bookmark-usage
        return
    fi

    cat $bookmarkpath
}

bookmarks() {
    show-booksmarks
}