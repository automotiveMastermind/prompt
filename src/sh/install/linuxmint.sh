#!/usr/bin/env sh

__am_prompt_install_mint() {
    local SUDO=$(command -v sudo 2>/dev/null || "")
    local PACKAGES='sudo build-essential curl file git bash'

    $ECHO "${CLR_SUCCESS}updating software repositories...${CLR_CLEAR}"
    $SUDO apt-get update

    for pkg in $PACKAGES; do
        $ECHO "${CLR_SUCCESS}installing $pkg...${CLR_CLEAR}"
        $SUDO apt-get install -y ${pkg}
    done

    $ECHO "${CLR_SUCCESS}removing unnecessary dependencies...${CLR_CLEAR}"
    $SUDO apt-get autoremove -y

    . "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_mint
