#!/usr/bin/env bash

__am-prompt-install-centos() {
    local YUM=$(command -v dnf 2>/dev/null || command -v yum)
    local PACKAGES=(curl file git which)

    __am-prompt-success "installing development tools..."
    sudo $YUM groupinstall -y "Development Tools"

    for pkg in "${PACKAGES[@]}"; do
        __am-prompt-success  "installing $pkg..."
        sudo $YUM install -y ${pkg}
    done

    source "$SCRIPT_DIR/uname/install-linux.sh"
}

__am-prompt-install-centos
