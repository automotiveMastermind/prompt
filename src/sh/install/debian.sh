#!/usr/bin/env sh

set -e

__am_prompt_install_debian() {
    local SUDO=$(command -v sudo 2>/dev/null || "")
    local PACKAGES='sudo build-essential curl file git bash'

    $ECHO "${CLR_SUCCESS}updating software repositories...${CLR_CLEAR}"
    $SUDO apt-get update

    $ECHO "${CLR_SUCCESS}installing $PACKAGES...${CLR_CLEAR}"
    $SUDO apt-get install -y ${PACKAGES}

    $ECHO "${CLR_SUCCESS}removing unnecessary dependencies...${CLR_CLEAR}"
    $SUDO apt-get autoremove -y

    . "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_debian
