#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-backup'
fi

remove-backup() {
    rm -rf $HOME/.am/prompt/backup 2>/dev/null
}