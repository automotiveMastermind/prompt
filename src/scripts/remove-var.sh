#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'remove-var'
fi

remove-var() {
    local v=$1
    local r=
    local scripts_path=$HOME/.pulsebridge/prompt/scripts

    if [ -z "${v:-}" ]; then
        r=$(grep -s -m 1 ^$v $scripts_path/variables.sh)
    fi

    if [ ! -z "${r:-}" ]; then
        [ -z "${2:-}" ] && (echo Removing variable: $r)

        grep -s -v $r $scripts_path/variables.sh >> $scripts_path/variables1.sh
        mv -f $scripts_path/variables1.sh $scripts_path/variables.sh

        . $scripts_path/variables.sh
    elif [ -z "${2:-}" ]; then
        echo No variable was declared for the specified name.
    fi
}