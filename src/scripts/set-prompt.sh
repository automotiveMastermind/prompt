#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'set-prompt'
fi

function emit-prompt-arrow() {
    # set the default color
    local CLR_PROMPT=$CLR_USER_PROMPT

    # set color for staff user (administrator)
    if ! test -z "$(command id -Gn 2>/dev/null | grep -s -o admin)"; then
        CLR_PROMPT=$CLR_STAFF_PROMPT
    fi

    # set color for root user
    if test $(id -u) -eq 0; then
        CLR_PROMPT=$CLR_ROOT_PROMPT
    fi

    # set the color for an ssh session
    if test -n "${SSH_CONNECTION+1}"; then
        CLR_PROMPT=$CLR_SSH_PROMPT

        # emit the prompt using the correct color
        echo "\[${CLR_PROMPT}\] (ssh) ==> \[${CLR_CLEAR}\]"
    else
        # emit the prompt using the correct color
        echo "\[${CLR_PROMPT}\] ==> \[${CLR_CLEAR}\]"
    fi
}

function set-prompt() {
    local bash_completion=$LOCAL_PREFIX/etc/bash_completion.d

    if test -d "$bash_completion"; then
        for f in $bash_completion/*; do
            source $f
        done
    fi

    if type gulp 1>/dev/null 2>&1; then
        eval "$(gulp --completion=bash)" 1>/dev/null 2>&1;
    fi

    if type grunt 1>/dev/null 2>&1; then
        eval "$(grunt --completion=bash)" 1>/dev/null 2>&1;
    fi

    if type npm 1>/dev/null 2>&1; then
        eval "$(npm completion)" 1>/dev/null 2>&1;
    fi

    # set the window title
    echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}\007"

    if ! type git 1>/dev/null 2>&1; then
        export PROMPT_COMMAND='"\n\u@\h : \w\n" "$(emit-prompt-arrow)"'
    else
        # use the git prompt with the prompt arrow
        export PROMPT_COMMAND='__posh_git_ps1 "\n\u@\h : \w\n" "$(emit-prompt-arrow)"'
    fi
}

set-prompt