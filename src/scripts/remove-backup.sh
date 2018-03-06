#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'remove-backup'
fi

remove-backup() {
    local BACKUP=$1

    if [ -z ${BACKUP:-} ]; then
        BACKUP='prompt'
    fi

    rm -rf "$AM_HOME/backup/$BACKUP" 2>/dev/null
}