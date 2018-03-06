#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'update-prompt'
fi

update-prompt() {
    local SHA=$(git-sha)
    local SHA_PATH=$HOME/.am/prompt/.sha

    if [ "${1:-}" = "--force" ]; then
        rm -rf $SHA_PATH 1>/dev/null 2>&1
    fi

    remove-backup

    if [ -f ${SHA_PATH:-} ]; then
        CURRENT_SHA=$(cat $SHA_PATH)

        if [ -z ${SHA:-} ]; then
            echo "prompt: SHA cannot be retrieved, which could be related to rate limiting."
            return 1
        fi

        if [ "${SHA:-}" = "${CURRENT_SHA:-}" ]; then
            echo "prompt: latest version already installed: $SHA"
            return 0
        fi
    fi

    local CHANGELOG_URI="https://github.com/automotivemastermind/prompt/blob/master/CHANGELOG.md"
    local UPDATE_URI="https://github.com/automotivemastermind/prompt/archive/master.tar.gz"
    local UPDATE_TEMP=$(mktemp -d)

    pushd $UPDATE_TEMP 1>/dev/null
    curl -skL $UPDATE_URI | tar zx
    pushd prompt-master 1>/dev/null
    ./install.sh
    popd 1>/dev/null
    popd 1>/dev/null

    rm -rf $UPDATE_TEMP 1>/dev/null

    open-url $CHANGELOG_URI 1>/dev/null
}