#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'do-repeat'
fi

do-repeat() {
    local count=$1
    local cmd="${*:2}"

    for (( current=1; current<=$count; current++ )); do $cmd; done
}

redo() {
    do-repeat $@
}