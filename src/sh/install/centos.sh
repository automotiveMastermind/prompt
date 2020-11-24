#!/usr/bin/env sh

__am_prompt_install_centos() {
    local SUDO=$(command -v sudo 2>/dev/null || "")
    local YUM=$(command -v dnf 2>/dev/null || command -v yum)
    local PACKAGES='sudo curl file git which findutils bash util-linux-user'

    $ECHO "${CLR_SUCCESS}installing development tools...${CLR_CLEAR}"
    $SUDO $YUM groupinstall -y "Development Tools"

    $ECHO "${CLR_SUCCESS}installing $PACKAGES...${CLR_CLEAR}"
    $SUDO $YUM install -y ${PACKAGES}

    . "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_centos
