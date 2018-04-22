#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'list-directory'
fi

if ! type "la" 1>/dev/null 2>&1; then
    la() {
        ls -la $@
    }
fi

if ! type "ll" 1>/dev/null 2>&1; then
    ll() {
        ls -lh $@
    }
fi

if ! type "lla" 1>/dev/null 2>&1; then
    lla() {
        ls -lha $@
    }
fi

if ! type "lsp" 1>/dev/null 2>&1; then
    lsp() {
        ls -p $@
    }
fi