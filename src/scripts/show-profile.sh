#!/usr/bin/env bash

function show-profile() {
    history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr
}

function showprofile() {
    show-profile
}

function myprofile() {
    show-profile
}