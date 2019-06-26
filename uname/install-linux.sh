#!/usr/bin/env bash

__am-prompt-install-linux() {
    local BREWS=(gcc git bash bash-completion)

    if ! type brew 1>/dev/null 2>&1; then
        __am-prompt-success 'installing homebrew...'
        sh -c "yes | $(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh) && brew config"

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

    local BASH_SHELL=$HOMEBREW_PREFIX/bin/bash

    if ! grep "$$BASH_SHELL" /etc/shells 1>/dev/null 2>&1; then
        __am-prompt-success 'adding updated bash to shells...'
        sudo bash -c "echo $BASH_SHELL >> /etc/shells"
    fi

    if [[ "$SHELL" != "/usr/local/bin/bash" ]]; then
        __am-prompt-success 'setting updated bash to default shell for user...'
        sudo chsh -s $BASH_SHELL $USER
    fi

    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"

    nvm install --lts
    nvm use --lts --delete-prefix
}

__am-prompt-install-linux
