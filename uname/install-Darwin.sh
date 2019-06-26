#!/usr/bin/env bash

__am-prompt-install-darwin() {
    local BREWS=(bash openssl git go nvm bash-completion python)

    if ! type brew 1>/dev/null 2>&1; then
        __am-prompt-success 'installing homebrew...'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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

    if ! grep "/usr/local/bin/bash" /etc/shells 1>/dev/null 2>&1; then
        __am-prompt-success 'adding updated bash to shells...'
        sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    fi

    if [[ "$SHELL" != "/usr/local/bin/bash" ]]; then
        __am-prompt-success 'setting updated bash to default shell for user...'
        sudo chsh -s /usr/local/bin/bash $USER
    fi

    mkdir -p /usr/local/lib 1>/dev/null 2>&1
    ln -sf /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1
    ln -sf /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1

    local NVM_PATH=$(brew --prefix nvm)

    if [ -f "$NVM_PATH/nvm.sh" ]; then
        __am-prompt-success 'setting up nvm...'
        export NVM_DIR="${HOME}/.nvm"
        source "$NVM_PATH/nvm.sh"
        nvm install --lts 2>/dev/null
        nvm use --lts --delete-prefix --silent 2>/dev/null
    fi

    __am-prompt-success 'setting git credential helper to use the macOS keychain'
    git config --system credential.helper osxkeychain
}

__am-prompt-install-darwin
