#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-backup'
fi

remove-backup() {
    local backup=$1

    if [ -z "${backup:-}" ]; then
        backup="prompt"
    fi

    rm -rf "$HOME/.am/backup/$backup" 2>/dev/null
}