#!/usr/bin/env bash

__am-prompt-install-debian() {
    local PACKAGES=(build-essential curl file git ruby)

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

__am-prompt-install-debian
