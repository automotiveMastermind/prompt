#!/usr/bin/env bash

CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

__prompt-install-darwin() {
    if ! type brew 1>/dev/null 2>&1; then
        __prompt-success 'installing homebrew'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    __prompt-success 'updating homebrew'
    brew update 1>/dev/null

    for pkg in git-flow; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            __prompt-success "uninstalling: $pkg"
            brew uninstall $pkg 1>/dev/null 2>&1
        fi
    done

    for pkg in bash openssl git git-extras git-flow-avh nvm bash-completion; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            __prompt-success "upgrading: $pkg"
            brew upgrade $pkg 1>/dev/null 2>&1
            brew link --overwrite $pkg 1>/dev/null 2>&1
        else
            __prompt-success "installing: $pkg"
            brew install $pkg 1>/dev/null 2>&1
        fi
    done

    if ! grep "/usr/local/bin/bash" /etc/shells 1>/dev/null 2>&1; then
        __prompt-success 'adding updated bash to shells...'
        sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    fi

    if [[ "$SHELL" != "/usr/local/bin/bash" ]]; then
        __prompt-success 'setting updated bash to default shell for user...'
        chsh -s /usr/local/bin/bash
    fi

    mkdir -p /usr/local/lib 1>/dev/null 2>&1
    ln -s /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1
    ln -s /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1

    nvm_path=$(brew --prefix nvm)

    if [ -d $nvm_path ]; then
        export NVM_DIR="$HOME/.nvm"

        if [ ! -d $NVM_DIR ]; then
            mkdir -p "$NVM_DIR"
        fi

        source "$nvm_path/nvm.sh"

        nvm install --lts 1>/dev/null 2>&1
        nvm use --lts --delete-prefix 1>/dev/null 2>&1
    fi

    __prompt-success 'setting git credential helper to use the macOS keychain'
    git config --system credential.helper osxkeychain 1>/dev/null
}

__prompt-install-darwin