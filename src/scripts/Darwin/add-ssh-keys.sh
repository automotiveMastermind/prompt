#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'add-ssh-keys'
fi
function add-ssh-keys() {
	ssh-add -A 2>/dev/null
}

# this is a workaround for the new behavior in macOS Sierra where
# private key pass-phrases are no longer loaded from the keychain
# by default
add-ssh-keys