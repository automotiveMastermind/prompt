#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'remove-directory'
fi

rd() {
    rm -r $@
}