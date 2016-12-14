#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-directory'
fi

function rd() {
    rm -dRr $@
}