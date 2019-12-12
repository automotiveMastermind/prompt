#!/usr/bin/env sh

__am_prompt_install_centos() {
    local YUM=$(command -v dnf 2>/dev/null || command -v yum)
    local PACKAGES='curl file git which'

    $ECHO "${CLR_SUCCESS}installing development tools...${CLR_CLEAR}"
    sudo $YUM groupinstall -y "Development Tools"

    for pkg in $PACKAGES; do
        $ECHO "${CLR_SUCCESS}installing $pkg...${CLR_CLEAR}"
        sudo $YUM install -y ${pkg}
    done

    . "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_centos
