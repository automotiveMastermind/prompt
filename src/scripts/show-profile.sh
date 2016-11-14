#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'show-profile'
fi

function show-profile() {
    history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr
}

function showprofile() {
    show-profile
}

function myprofile() {
    show-profile
}