#!/usr/bin/env sh

set -e

__am_prompt_install_linux() {

    local BREWS='gcc git gpg'

    if ! type brew 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        bash -c "CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) || true"

        . "$AM_PROMPT/sh/scripts/eval/set-brew-path"
    fi

    $ECHO "${CLR_SUCCESS}updating homebrew...${CLR_CLEAR}"
    brew update

    set +e

    for pkg in $BREWS; do
        if brew list --formula -1 | grep -q "^${pkg}\$"; then
            $ECHO "${CLR_SUCCESS}upgrading: $pkg...${CLR_CLEAR}"
            brew upgrade $pkg 2>/dev/null
            brew link --overwrite $pkg 2>/dev/null
        else
            $ECHO "${CLR_SUCCESS}installing: $pkg...${CLR_CLEAR}"
            brew install $pkg
        fi
    done

    # make sure we have ownership of linuxbrew
    sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew
}

__am_prompt_install_nvm() {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"

    nvm install --lts
    nvm use --lts --delete-prefix
}

__am_prompt_install_linux
__am_prompt_install_nvm
