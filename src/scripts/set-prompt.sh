function emit-prompt-arrow()
{
    # set the default color
    local CLR_PROMPT=$CLR_USER_PROMPT

    # set color for staff user (administrator)
    if [ ! -z "$(command id -Gn | grep -s -o admin)" ]; then
        CLR_PROMPT=$CLR_STAFF_PROMPT
    fi

    # set color for root user
    if [ $(id -u) -eq 0 ]; then
        CLR_PROMPT=$CLR_ROOT_PROMPT
    fi
    
    # set the color for an ssh session
    if [ "$SSH_CONNECTION" ]; then
        CLR_PROMPT=$CLR_SSH_PROMPT
        
        # emit the prompt using the correct color
        echo "\[${CLR_PROMPT}\] (ssh) ==> \[${CLR_CLEAR}\]"
    else
        # emit the prompt using the correct color
        echo "\[${CLR_PROMPT}\] ==> \[${CLR_CLEAR}\]"
    fi
}

for f in $LOCAL_PREFIX/etc/bash_completion.d/*; do
    source $f
done

if type gulp 1>/dev/null 2>&1; then
    eval "$(gulp --completion=bash)"
fi

if type grunt 1>/dev/null 2>&1; then
    eval "$(grunt --completion=bash)"
fi

if type npm 1>/dev/null 2>&1; then
    eval "$(npm completion)"
fi

function set-prompt() {
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