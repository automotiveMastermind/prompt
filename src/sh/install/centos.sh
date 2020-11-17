#!/usr/bin/env sh

__am_prompt_install_centos() {
    local SUDO=$(command -v sudo 2>/dev/null || "")
    local YUM=$(command -v dnf 2>/dev/null || command -v yum)
    local PACKAGES='sudo curl file git which findutils bash'

    $ECHO "${CLR_SUCCESS}installing development tools...${CLR_CLEAR}"
    $SUDO $YUM groupinstall -y "Development Tools"

    for pkg in $PACKAGES; do
        $ECHO "${CLR_SUCCESS}installing $pkg...${CLR_CLEAR}"
        $SUDO $YUM install -y ${pkg}
    done

    . "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_centos
