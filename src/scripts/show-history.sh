#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-history'
fi

function show-history() {
	history $@
}

function lh() {
	history $@
}