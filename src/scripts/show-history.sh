#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'show-history'
fi

function show-history() {
	history $@
}

function lh() {
	history $@
}