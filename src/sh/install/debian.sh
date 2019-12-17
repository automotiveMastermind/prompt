#!/usr/bin/env sh

__am_prompt_install_debian() {
    local PACKAGES='build-essential curl file git'

    $ECHO "${CLR_SUCCESS}updating software repositories...${CLR_CLEAR}"
    sudo apt-get update

    for pkg in $PACKAGES; do
        $ECHO "${CLR_SUCCESS}installing $pkg...${CLR_CLEAR}"
        sudo apt-get install -y ${pkg}
    done

    $ECHO "${CLR_SUCCESS}removing unnecessary dependencies...${CLR_CLEAR}"
    sudo apt-get autoremove -y

    . "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_debian

