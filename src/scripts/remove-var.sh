#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'remove-var'
fi

remove-var-usage() {
    echo 'remove-var <name> <value>'
    echo '     name  : a name for your variable'
}

remove-var() {
    local VARIABLE=$1
    local REMOVE=
    local USER_PATH="$AM_PROMPT/user"
    local VAR_PATH="$USER_PATH/variables.sh"

    if [ -z "${VARIABLE:-}" ]; then
        remove-var-usage
        return 1
    fi

    REMOVE=$(grep -s -m 1 ^$VARIABLE $VAR_PATH)
    unset $VARIABLE 1>/dev/null 2>&1

    if [ -z ${REMOVE+x} ]; then
        echo 'remove-var: no variable was declared for the specified name'

        return 1
    fi

    echo "remove-var: removing variable $REMOVE"

    grep -s -v ^$VARIABLE "$VAR_PATH" >> "$USER_PATH/variables1.sh"
    mv -f "$USER_PATH/variables1.sh" "$USER_PATH/variables.sh"

    source "$USER_PATH/variables.sh"
}