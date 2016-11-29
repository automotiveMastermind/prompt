#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
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