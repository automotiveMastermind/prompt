#!/usr/bin/env bash

CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

__prompt-success() {
    echo -e "${CLR_SUCCESS}prompt-install: $1${CLR_CLEAR}"
}

__prompt-install() {
    local AM_HOME="$HOME/.am"
    local AM_PROMPT="$AM_HOME/prompt"

    local NOW=$(date +"%Y%m%d_%H%M%S")
    local BACKUP_PATH="$AM_HOME/backup/prompt/$NOW"

    __prompt-success "creating backup path: $BACKUP_PATH"
    mkdir -p "$BACKUP_PATH" 1>/dev/null

    for template in template/*; do
        local name=$(basename "$template")
        local path="$HOME/.${name}"

        if [ -f "$path" ]; then
            __prompt-success "backing up ${name}"
            cp "$path" "$BACKUP_PATH/$name"
        fi

        cat "$template" > "$path"
    done

    if [ -d $AM_PROMPT ]; then
        __prompt-success "backing up $AM_PROMPT"
        cp -R $AM_PROMPT/* "$BACKUP_PATH" 1>/dev/null

        __prompt-success "removing $AM_PROMPT"
        rm -rf "$AM_PROMPT/git" 1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/scripts" 1>/dev/null 2>&1
        rm -rf "$AM_PROMPT/themes" 1>/dev/null 2>&1
        rm -f "$AM_PROMPT/bashrc" 1>/dev/null 2>&1
    fi

    __prompt-success "creating $AM_PROMPT"
    mkdir -p "$AM_PROMPT/user" 1>/dev/null 2>&1

    __prompt-success "installing promptMastermind to $AM_PROMPT"
    cp -Rf src/git "$AM_PROMPT" 1>/dev/null
    cp -Rf src/scripts "$AM_PROMPT" 1>/dev/null
    cp -Rf src/themes "$AM_PROMPT" 1>/dev/null
    cp -f src/bashrc "$AM_PROMPT" 1>/dev/null

    for useritem in src/user/*; do
        local name=$(basename "$useritem")
        local path="$AM_PROMPT/user/$name"

        if [ ! -f "$path" ]; then
            __prompt-success "initializing user profile: $name at $path"
            cp "$useritem" "$path"
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
    local GIT_COMPLETE_NAME=git-flow-completion.bash
    local GIT_PROMPT_URI=https://raw.githubusercontent.com/lyze/posh-git-sh/master/$GIT_PROMPT_NAME
    local GIT_COMPLETE_URI=https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/$GIT_COMPLETE_NAME
    local PROMPT_COMPLETION="$AM_PROMPT/completions"

    if [ -f "$BASH_COMPLETION/$GIT_COMPLETE_NAME" ]; then
        __prompt-success 'removing git flow bash completion'
        rm -rf "$BASH_COMPLETION/$GIT_COMPLETE_NAME" 1>/dev/null
    fi

    if [ -f "$BASH_COMPLETION/$GIT_PROMPT_NAME" ]; then
        __prompt-success 'removing crappy git-prompt'
        rm -rf "$BASH_COMPLETION/$GIT_PROMPT_NAME" 1>/dev/null
    fi

    if [ ! -d "$PROMPT_COMPLETION" ]; then
        mkdir -p "$PROMPT_COMPLETION" 1>/dev/null
    fi

    __prompt-success 'downloading better git-prompt'
    local result=$(curl -sLD- "$GIT_PROMPT_URI" -o "$PROMPT_COMPLETION/$GIT_PROMPT_NAME" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

    if [ "$result" = "200" ]; then
        __prompt-success 'successfully installed git-prompt'
        chmod +x "PROMPT_COMPLETION/$GIT_PROMPT_NAME" 1>/dev/null 2>&1
    fi

    __prompt-success 'downloading git-flow completion'
    local result=$(curl -sLD- "$GIT_COMPLETE_URI" -o "$PROMPT_COMPLETION/$GIT_COMPLETE_NAME" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

    if [ "$result" = "200" ]; then
        __prompt-success 'successfully installed git-flow completion'
        chmod +x "$PROMPT_COMPLETION/$GIT_COMPLETE_NAME" 1>/dev/null 2>&1
    fi

    local CURL_OPT='-s'

    if [ ! -z "${GH_TOKEN:-}" ]; then
        local CURL_OPT="$CURL_OPT -H 'Authorization: token $GH_TOKEN'"
    fi

    local SHA_URI="https://api.github.com/repos/automotivemastermind/prompt/commits/master"
    local PROMPT_SHA=$(curl $CURL_OPT $SHA_URI | grep sha | head -n 1 | sed 's#.*\:.*"\(.*\).*",#\1#')
    local PROMPT_SHA_PATH=$HOME/.am/prompt/$PROMPT_SHA

    touch "$PROMPT_SHA_PATH"

    echo -e "${CLR_SUCCESS}"
    echo "#######################################"
    echo "#######################################"
    echo "   PLEASE RUN: exec -l \$SHELL"
    echo "#######################################"
    echo "#######################################"
    echo -e "${CLR_CLEAR}"

    source "$AM_PROMPT/bashrc"
}

__prompt-install