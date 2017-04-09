#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'add-ssh-keys'
fi

__prompt-add-ssh-keys() {
	ssh-add -A 2>/dev/null
}

# this is a workaround for the new behavior in macOS Sierra where
# private key pass-phrases are no longer loaded from the keychain
# by default
__prompt-add-ssh-keys