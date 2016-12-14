#!/usr/bin/env bash

CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

function success() {
    echo -e "${CLR_SUCCESS}$1${CLR_CLEAR}"
}

if ! type brew 1>/dev/null 2>&1; then
    success "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

success "Updating Homebrew..."
brew update 1>/dev/null

for pkg in git-flow; do
    if brew list -1 | grep -q "^${pkg}\$"; then
        success "Uninstalling $pkg..."
        brew uninstall ${pkg} 1>/dev/null 2>&1
    fi
done

for pkg in openssl git git-extras git-flow-avh nvm; do
    if brew list -1 | grep -q "^${pkg}\$"; then
        success "Upgrading $pkg..."
        brew upgrade ${pkg} 1>/dev/null 2>&1
        brew link --overwrite ${pkg} 1>/dev/null 2>&1
    else
        success "Installing $pkg..."
        brew install ${pkg} 1>/dev/null 2>&1
    fi

    mkdir -p /usr/local/lib 1>/dev/null 2>&1
    ln -s /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1
    ln -s /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/ 1>/dev/null 2>&1
done

nvm_path=$(brew --prefix nvm)

if [ -d $nvm_path ]; then
    export NVM_DIR=$HOME/.nvm

    if [ ! -d $NVM_DIR ]; then
        mkdir -p $NVM_DIR
    fi

    . $nvm_path/nvm.sh

    nvm install --lts 1>/dev/null 2>&1
    nvm use --lts 1>/dev/null 2>&1
fi

success "Setting git credential helper to use the macOS keychain..."
git config --system credential.helper osxkeychain 1>/dev/null