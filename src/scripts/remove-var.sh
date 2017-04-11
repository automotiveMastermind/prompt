#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-var'
fi

remove-var-usage() {
    echo 'remove-var <name> <value>'
    echo '     name  : a name for your variable'
}

remove-var() {
    local variable=$1
    local r=
    local userpath="$AM_PROMPT/user"
    local varpath="$userpath/variables.sh"

    if [ -z "${variable:-}" ]; then
        remove-var-usage
        return 1
    fi

    r=$(grep -s -m 1 ^$variable $varpath)
    unset "$variable" 1>/dev/null 2>&1

    if [ -z "${r:-}" ]; then
        echo 'remove-var: no variable was declared for the specified name'

        return 1
    fi

    echo "remove-var: removing variable $row"

    grep -s -v ^$variable "$varpath" >> "$userpath/variables1.sh"
    mv -f "$userpath/variables1.sh" "$userpath/variables.sh"

    source "$userpath/variables.sh"
}