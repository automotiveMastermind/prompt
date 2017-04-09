#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-colors'
fi

show-colors() {
    echo

    for color in $(env | awk '/^CLR_BRIGHT/' | cut -d= -f1 | sort); do
        echo -e "${!color}\$$color${CLR_CLEAR}"
    done

    echo

    for color in $(env | awk '/^CLR_/' | awk '!/^CLR_BRIGHT/' | awk '!/_PROMPT/' | cut -d= -f1 | sort); do
        echo -e "${!color}\$$color${CLR_CLEAR}"
    done

    echo

    for color in $(env | awk '/^CLR/' | awk '/_PROMPT/' | cut -d= -f1 | sort); do
        echo -e "${!color}\$$color${CLR_CLEAR}"
    done
}

colors() {
    show-colors
}

lc() {
    show-colors
}