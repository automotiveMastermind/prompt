#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'remove-backup'
fi

remove-backup() {
    local backup=$1

    if [ -z "${backup:-}" ]; then
        backup='prompt'
    fi

    rm -rf "$AM_HOME/backup/$backup" 2>/dev/null
}