#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'add-var'
fi

add-var-usage() {
    echo '[add-var|set-var] <name> <value>'
    echo '     name  : a name for your variable'
    echo '     value : a value for your variable'
}

add-var() {
    # make sure that a bookmark was specified.
    if [ -z ${1:-} ]; then
        echo 'add-var: missing <name>'
        add-var-usage
        return
    fi

    if [ -z ${2:-} ]; then
        echo 'add-var: missing <value>'
        add-var-usage
        return
    fi

    # make sure we remove any existing variable before defining another one
    remove-var $1 silent
    local VARIABLE="$1"=\"$2\"
    local VAR_PATH="$AM_PROMPT/user/variables.sh"

    echo 'Adding varable: $VARIABLE'
    echo >> "$VAR_PATH"
    echo "$VARIABLE" >> "$VAR_PATH"
    source "$VAR_PATH"
}

set-var() {
    add-var $@
}