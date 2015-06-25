# make sure that git prompt is sourced first
source ~/.ssh/scripts/git-prompt.sh

function emit-prompt-arrow()
{
    # set the default color
    local CLR_PROMPT=$CLR_USER_PROMPT

    # set color for staff user (administrator)
    if [ ! -z '`command id -Gn | grep -s -o admin`' ]; then
        CLR_PROMPT=$CLR_STAFF_PROMPT
    fi

    # set color for root user
    if [ $(id -u) -eq 0 ]; then
        CLR_PROMPT=$CLR_ROOT_PROMPT
    fi

    echo "\[${CLR_PROMPT}\] ==> \[${CLR_CLEAR}\]"
}

function set-prompt() {
    # set the window title
    echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}\007"

    export PROMPT_COMMAND='__git_ps1 "\n\u@\h : \w\n" "`emit-prompt-arrow`"'

    # specify the two-line prompt with color-coded arrow
    # export PS1="\n\u@\h : \w\n  $(__git_ps1 '(%s)')\[${CLR_PROMPT}\] ==> \[${CLR_CLEAR}\]"
}

set-prompt