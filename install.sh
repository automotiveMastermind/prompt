#!/usr/bin/env bash

CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

__am-prompt-success() {
    echo -e "${CLR_SUCCESS}prompt-install: $1${CLR_CLEAR}"
}

__am-prompt-install() {
    local AM_HOME="$HOME/.am"
    local AM_PROMPT="$AM_HOME/prompt"

    local NOW=$(date +"%Y%m%d_%H%M%S")
    local BACKUP_PATH="$AM_HOME/backup/prompt/$NOW"

    __am-prompt-success "creating backup path: $BACKUP_PATH"
    mkdir -p "$BACKUP_PATH" 1>/dev/null

    for TEMPLATE in template/*; do
        local TEMPLATE_NAME=$(basename "$TEMPLATE")
        local TEMPLATE_PATH="$HOME/.${TEMPLATE_NAME}"

        if [ -f "$TEMPLATE_PATH" ]; then
            __am-prompt-success "backing up ${TEMPLATE_NAME}"
            cp "$TEMPLATE_PATH" "$BACKUP_PATH/$TEMPLATE_NAME"
        fi

        cat "$TEMPLATE" > "$TEMPLATE_PATH"
    done

    if [ -d $AM_PROMPT ]; then
        __am-prompt-success "backing up $AM_PROMPT"
        cp -R $AM_PROMPT/* "$BACKUP_PATH" 1>/dev/null

        __am-prompt-success "removing $AM_PROMPT"
        rm -rf "$AM_PROMPT/git" 1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/scripts" 1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/themes" 1>/dev/null 2>&1
        rm -f "$AM_PROMPT/bashrc" 1>/dev/null 2>&1
    fi

    __am-prompt-success "creating $AM_PROMPT"
    mkdir -p "$AM_PROMPT/user" 1>/dev/null 2>&1

    __am-prompt-success "installing promptMastermind to $AM_PROMPT"
    cp -Rf src/scripts "$AM_PROMPT" 1>/dev/null
    cp -Rf src/themes "$AM_PROMPT" 1>/dev/null
    cp -f src/bashrc "$AM_PROMPT" 1>/dev/null

    for USER_ITEM in src/user/*; do
        local USER_ITEM_NAME=$(basename "$USER_ITEM")
        local USER_ITEM_PATH="$AM_PROMPT/user/$USER_ITEM_NAME"

        if [ ! -f "$USER_ITEM_PATH" ]; then
            __am-prompt-success "initializing user profile: $USER_ITEM_NAME at $USER_ITEM_PATH"
            cp "$USER_ITEM" "$USER_ITEM_PATH"
        fi
    done

    if type brew 1>/dev/null 2>&1; then
        local LOCAL_PREFIX=$(brew --prefix)
    elif [ -d $LOCALAPPDATA/git ]; then
        local LOCAL_PREFIX=$(echo "/$LOCALAPPDATA/git" | sed -e 's/\\/\//g' -e 's/://')
    else
        local LOCAL_PREFIX=/usr/local
    fi

    local BASH_COMPLETION="$LOCAL_PREFIX/etc/bash_completion.d"
    local UNAME=$(uname)
    local UNAME_INSTALL="./uname/install-$UNAME.sh"

    if [ -e /etc/os-release ]; then
        source /etc/os-release

        local UNAME_INSTALL="./uname/install-$ID.sh"
    fi

    if [ -f "$UNAME_INSTALL" ]; then
        source "$UNAME_INSTALL"
    fi

    local GIT_PROMPT_NAME=git-prompt.sh
    local GIT_PROMPT_URI=https://raw.githubusercontent.com/lyze/posh-git-sh/master/$GIT_PROMPT_NAME
    local PROMPT_COMPLETION="$AM_PROMPT/completions"

    if [ -f "$BASH_COMPLETION/$GIT_PROMPT_NAME" ]; then
        __am-prompt-success 'removing crappy git-prompt'
        rm -rf "$BASH_COMPLETION/$GIT_PROMPT_NAME" 1>/dev/null
    fi

    if [ ! -d "$PROMPT_COMPLETION" ]; then
        mkdir -p "$PROMPT_COMPLETION" 1>/dev/null
    fi

    __am-prompt-success 'downloading better git-prompt'
    local CURL_RESULT=$(curl -sLD- "$GIT_PROMPT_URI" -o "$PROMPT_COMPLETION/$GIT_PROMPT_NAME" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

    if [ "$CURL_RESULT" = "200" ]; then
        __am-prompt-success 'successfully installed git-prompt'
        chmod +x "PROMPT_COMPLETION/$GIT_PROMPT_NAME" 1>/dev/null 2>&1
    fi

    local CURL_OPT='-s'

    if [ ! -z "${GH_TOKEN:-}" ]; then
        local CURL_OPT="$CURL_OPT -H 'Authorization: token $GH_TOKEN'"
    fi

    local SHA_URI="https://api.github.com/repos/automotivemastermind/prompt/commits/master"
    local PROMPT_SHA=$(curl $CURL_OPT $SHA_URI | grep sha | head -n 1 | sed 's#.*\:.*"\(.*\).*",#\1#')
    local PROMPT_SHA_PATH=$HOME/.am/prompt/.sha

    echo $PROMPT_SHA > $PROMPT_SHA_PATH

    echo -e "${CLR_SUCCESS}"
    echo "#######################################"
    echo "#######################################"
    echo "   PLEASE RUN: exec -l \$SHELL"
    echo "#######################################"
    echo "#######################################"
    echo -e "${CLR_CLEAR}"
}

__am-prompt-install
