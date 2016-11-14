#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'show-history'
fi

function show-history() {
	history $@
}

function lh() {
	history $@
}