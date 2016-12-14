#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-backup'
fi

remove-backup() {
    rm -rf $HOME/.pulsebridge/prompt/backup 2>/dev/null
}