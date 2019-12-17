#!/usr/bin/env sh

__am_prompt_install_linux() {
    local BREWS='gcc git'

    if ! type brew 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        sh -c "yes | $(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh) && brew config"

        . "$AM_PROMPT/sh/scripts/eval/set-brew-path"
    fi

    $ECHO "${CLR_SUCCESS}updating homebrew...${CLR_CLEAR}"
    brew update

    set +e

    for pkg in $BREWS; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            $ECHO "${CLR_SUCCESS}upgrading: $pkg...${CLR_CLEAR}"
            brew upgrade $pkg 2>/dev/null
            brew link --overwrite $pkg 2>/dev/null
        else
            $ECHO "${CLR_SUCCESS}installing: $pkg...${CLR_CLEAR}"
            brew install $pkg
        fi
    done

    set -e

    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"

    nvm install --lts
    nvm use --lts --delete-prefix
}

__am_prompt_install_linux
