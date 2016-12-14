#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'list-directory'
fi

function la() {
    ls -la $@
}

function ll() {
    ls -lh $@
}

function lla() {
    ls -lha $@
}

function lp() {
    ls -p $@
}