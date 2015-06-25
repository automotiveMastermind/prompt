# make sure that git prompt is sourced first
source ~/.ssh/scripts/git-prompt.sh

function set-prompt() {
    # set the window title
    echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}\007"
	
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

    # specify the two-line prompt with color-coded arrow
    export PS1="\n\u@\h : \w\n  $(__git_ps1 '(%s)')\[${CLR_PROMPT}\] ==> \[${CLR_CLEAR}\]"
}

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="verbose"

# export the prompt command
export PROMPT_COMMAND=set-prompt
