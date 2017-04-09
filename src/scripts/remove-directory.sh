#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-directory'
fi

rd() {
    rm -dRr $@
}