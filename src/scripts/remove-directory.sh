#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'remove-directory'
fi

function rd() {
    rm -dRr $@
}