#!/usr/bin/env bash

__am-prompt-install-ubuntu() {
    local PACKAGES=(build-essential curl file git)

    __am-prompt-success "updating software repositories..."
    sudo apt-get update

    __am-prompt-success "install add-apt-repository..."
    sudo apt-get install -y software-properties-common

    __am-prompt-success "setting up git-core repository..."
    sudo add-apt-repository ppa:git-core/ppa -y

    __am-prompt-success "updating software repositories..."
    sudo apt-get update

    for pkg in "${PACKAGES[@]}"; do
        __am-prompt-success "installing $pkg..."
        sudo apt-get install -y ${pkg}
    done

    __am-prompt-success "removing unnecessary dependencies..."
    sudo apt-get autoremove -y

    source "$SCRIPT_DIR/uname/install-linux.sh"
}

__am-prompt-install-ubuntu
