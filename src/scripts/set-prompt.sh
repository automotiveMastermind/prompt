#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'set-prompt'
fi

__prompt-emit-prompt-arrow() {
    # set the default color
    local CLR_PROMPT=$CLR_USER_PROMPT

    # set color for staff user (administrator)
    if [ ! -z "$(command id -Gn 2>/dev/null | grep -s -o admin)" ]; then
        CLR_PROMPT=$CLR_STAFF_PROMPT
    fi

    # set color for root user
    if [ $(id -u) = 0 ]; then
        CLR_PROMPT=$CLR_ROOT_PROMPT
    fi

    # set the color for an ssh session
    if [ ! -z "${SSH_CONNECTION:-}" ]; then
        CLR_PROMPT=$CLR_SSH_PROMPT

        # emit the prompt using the correct color
        echo "\[${CLR_PROMPT}\] (ssh) ${AM_PROMPT_MARKER:-==>} \[${CLR_CLEAR}\]"
    else
        # emit the prompt using the correct color
        echo "\[${CLR_PROMPT}\] ${AM_PROMPT_MARKER:-==>} \[${CLR_CLEAR}\]"
    fi
}

__prompt-set-prompt() {
    if type gulp 1>/dev/null 2>&1; then
        eval "$(gulp --completion=bash)" 1>/dev/null 2>&1;
    fi

    if type grunt 1>/dev/null 2>&1; then
        eval "$(grunt --completion=bash)" 1>/dev/null 2>&1;
    fi

    if type npm 1>/dev/null 2>&1; then
        eval "$(npm completion)" 1>/dev/null 2>&1;
    fi

    if type kubectl 1>/dev/null 2>&1; then
        eval "$(kubectl completion bash)" 1>/dev/null 2>&1;
    fi

    if [ -f $LOCAL_PREFIX/etc/bash_completion ]; then
        source $LOCAL_PREFIX/etc/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    fi

    # source completions
    for completion in $AM_PROMPT/completions/*; do
        source $completion
    done

    # set the window title
    echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}\007"

    if ! type git 1>/dev/null 2>&1; then
        export PROMPT_COMMAND='"\n\u@\h : \w\n" "$(__prompt-emit-prompt-arrow)"'
    else
        # use the git prompt with the prompt arrow
        export PROMPT_COMMAND='__posh_git_ps1 "\n\u@\h : \w\n" "$(__prompt-emit-prompt-arrow)"'
    fi
}