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

LOCAL_PREFIX=$(brew --prefix)

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
done

nvm_path=$(brew --prefix nvm)

if test -d $nvm_path; then
    if ! test -d $HOME/.nvm; then
        mkdir -p $HOME/.nvm
    fi

    export NVM_DIR=~/.nvm

    . $nvm_path/nvm.sh

    nvm use --lts 1>/dev/null
fi

success "Setting git credential helper to use the macOS keychain..."
git config --system credential.helper osxkeychain 1>/dev/null