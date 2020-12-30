#!/usr/bin/env sh

set -e

SCRIPT_DIR=${2:-$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)}

export CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
export CLR_WARN="\033[1;33m"       # BRIGHT YELLOW
export CLR_CLEAR="\033[0m"         # DEFAULT COLOR
export ECHO='echo'

export HOMEBREW_NO_AUTO_UPDATE=1

# when not outputing to a tty, add spacing instead of colors
if [ ! -t 1 ]; then
    export CLR_SUCCESS="\n------------------------------------------------------------------------------------------------------------------------\n"
    export CLR_WARN=$CLR_SUCCESS
    export CLR_CLEAR=$CLR_SUCCESS
    export ECHO='echo'
fi

export AM_HOME="$HOME/.am"
export AM_PROMPT="$AM_HOME/prompt"

__am_prompt_success() {
    $ECHO "${CLR_SUCCESS}prompt-install: $1${CLR_CLEAR}"
}

__am_prompt_install() {
    local NOW=$(date +"%Y%m%d_%H%M%S")
    local BACKUP_PATH="$AM_HOME/backup/prompt/$NOW"

    __am_prompt_success "creating backup path: $BACKUP_PATH"
    mkdir -p "$BACKUP_PATH" 1>/dev/null

    for TEMPLATE in $SCRIPT_DIR/template/*; do
        local TEMPLATE_NAME=$(basename "$TEMPLATE")
        local TEMPLATE_PATH="$HOME/.${TEMPLATE_NAME}"

        if [ -f "$TEMPLATE_PATH" ]; then
            __am_prompt_success "backing up ${TEMPLATE_NAME}"
            cp "$TEMPLATE_PATH" "$BACKUP_PATH/$TEMPLATE_NAME"
        fi

        cp "$TEMPLATE" "$TEMPLATE_PATH"
    done

    if [ -d $AM_PROMPT ]; then
        __am_prompt_success "backing up $AM_PROMPT"
        cp -R $AM_PROMPT/* "$BACKUP_PATH" 1>/dev/null

        __am_prompt_success "removing $AM_PROMPT"
        rm -rf "$AM_PROMPT/bash"    1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/sh"      1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/zsh"     1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/themes"  1>/dev/null 2>&1

        # remove legacy paths
        rm -rf "$AM_PROMPT/completions" 1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/scripts"     1>/dev/null 2>&1
        rm -f "$AM_PROMPT/bashrc"       1>/dev/null 2>&1
    fi

    __am_prompt_success "creating $AM_PROMPT"
    mkdir -p "$AM_PROMPT/user" 1>/dev/null 2>&1

    __am_prompt_success "installing promptMastermind to $AM_PROMPT"
    cp -Rf "$SCRIPT_DIR/src/bash"   "$AM_PROMPT" 1>/dev/null
    cp -Rf "$SCRIPT_DIR/src/sh"     "$AM_PROMPT" 1>/dev/null
    cp -Rf "$SCRIPT_DIR/src/zsh"    "$AM_PROMPT" 1>/dev/null
    cp -Rf "$SCRIPT_DIR/src/themes" "$AM_PROMPT" 1>/dev/null

    for USER_ITEM in $SCRIPT_DIR/src/user/*; do
        local USER_ITEM_NAME=$(basename "$USER_ITEM")
        local USER_ITEM_PATH="$AM_PROMPT/user/$USER_ITEM_NAME"

        if [ ! -f "$USER_ITEM_PATH" ]; then
            __am_prompt_success "initializing user profile: $USER_ITEM_NAME at $USER_ITEM_PATH"
            cp "$USER_ITEM" "$USER_ITEM_PATH"
        fi
    done

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        local UNAMES="$ID $ID_LIKE"
    else
        local UNAMES=$(uname | tr '[:upper:]' '[:lower:]')
    fi

    local UNAME=
    until [ "$UNAME" = "$UNAMES" ]; do
        local UNAME=${UNAMES%%' '*}
        local UNAMES=${UNAMES#*' '}

        local UNAME_PATH="$AM_PROMPT/sh/install/$UNAME.sh"

        if [ ! -f "$UNAME_PATH" ]; then
            continue
        fi

        __am_prompt_success "installing platform prerequisites ($UNAME)"
        . "$UNAME_PATH"

        break
    done

    if [ ! -d "$AM_PROMPT/zsh/completions" ]; then
        mkdir -p "$AM_PROMPT/zsh/completions" 1>/dev/null
    fi

    if [ ! -d "$AM_PROMPT/bash/completions" ]; then
        mkdir -p "$AM_PROMPT/bash/completions" 1>/dev/null
    fi

    local PROMPT_SHA=$(cat "$SCRIPT_DIR/VERSION")
    local PROMPT_SHA_PATH=$HOME/.am/prompt/.sha

    echo $PROMPT_SHA > $PROMPT_SHA_PATH

    # get the requested shell
    local PROMPT_SHELL="${1:-}"

    # determine if the request shell was not set
    if [ -z "${PROMPT_SHELL:-}" ]; then

        # get the current shell
        PROMPT_SHELL=$(echo $SHELL | rev | cut -d'/' -f1 | rev)

        # test if the current shell is something other than zsh
        if [ "$PROMPT_SHELL" != "zsh" ]; then

            # default to bash
            PROMPT_SHELL="bash"
        fi
    fi

    # lowercase the prompt shell
    local PROMPT_SHELL=$(echo $PROMPT_SHELL | tr '[:upper:]' '[:lower:]')

    # use the correct shell
    "$AM_PROMPT/sh/scripts/use-shell" $PROMPT_SHELL

    # open the changelog url
    "$AM_PROMPT/sh/scripts/open-url" "https://github.com/automotivemastermind/prompt/blob/$PROMPT_SHA/CHANGELOG.md"
}

$ECHO
$ECHO "${CLR_WARN}prompt: establishing sudo (you may be prompted for credentials)...${CLR_CLEAR}"
sudo echo

trap '$ECHO; $ECHO; $ECHO "${CLR_WARN}prompt: terminating install...${CLR_CLEAR}"; exit 1;' INT

__am_prompt_install $@
