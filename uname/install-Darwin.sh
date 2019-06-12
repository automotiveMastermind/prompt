#!/usr/bin/env bash

CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

__am-prompt-install-darwin() {
    if ! type brew 1>/dev/null 2>&1; then
        __am-prompt-success 'installing homebrew'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    __am-prompt-success 'updating homebrew'
    brew update 1>/dev/null

    for pkg in git-flow; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            __am-prompt-success "uninstalling: $pkg"
            brew uninstall $pkg 1>/dev/null 2>&1
        fi
    done

    for pkg in bash openssl git go nvm bash-completion; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            __am-prompt-success "upgrading: $pkg"
            brew upgrade $pkg 1>/dev/null 2>&1
            brew link --overwrite $pkg 1>/dev/null 2>&1
        else
            __am-prompt-success "installing: $pkg"
            brew install $pkg 1>/dev/null 2>&1
        fi
    done

    if ! grep "/usr/local/bin/bash" /etc/shells 1>/dev/null 2>&1; then
        __am-prompt-success 'adding updated bash to shells...'
        sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    fi

    if [[ "$SHELL" != "/usr/local/bin/bash" ]]; then
        __am-prompt-success 'setting updated bash to default shell for user...'
        chsh -s /usr/local/bin/bash
    fi

    mkdir -p /usr/local/lib 1>/dev/null 2>&1
    ln -s /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1
    ln -s /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1

    local NVM_PATH=$(brew --prefix nvm)

    if [ -f "$NVM_PATH/nvm.sh" ]; then
        __am-prompt-success 'setting up nvm...'
        export NVM_DIR="${HOME}/.nvm"
        source "$NVM_PATH/nvm.sh"
        nvm install --lts 1>/dev/null 2>&1
        nvm use --lts --delete-prefix --silent 1>/dev/null 2>&1
    fi

    __am-prompt-success 'setting git credential helper to use the macOS keychain'
    git config --system credential.helper osxkeychain 1>/dev/null
}

__am-prompt-install-darwin
