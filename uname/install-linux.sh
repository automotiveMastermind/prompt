#!/usr/bin/env bash

__am-prompt-install-linux() {
    local BREWS=(gcc)

    if ! type brew 1>/dev/null 2>&1; then
        __am-prompt-success 'installing homebrew...'
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

        source "$SCRIPT_DIR/src/scripts/eval/set-brew-path"
    fi

    __am-prompt-success 'updating homebrew...'
    brew update

    set +e

    for pkg in "${BREWS[@]}"; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            __am-prompt-success "upgrading: $pkg..."
            brew upgrade $pkg 2>/dev/null
            brew link --overwrite $pkg 2>/dev/null
        else
            __am-prompt-success "installing: $pkg..."
            brew install $pkg
        fi
    done

    set -e

    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"

    nvm install --lts
    nvm use --lts --delete-prefix
}

__am-prompt-install-linux
