#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'git-extras'
fi

function git-lines() {
    git summary --line
}

function git-commits() {
    git summary
}

function lines() {
    git-lines
}

function commits() {
    git-commits
}