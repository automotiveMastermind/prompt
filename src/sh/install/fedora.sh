#!/usr/bin/env sh

set -e

__am_prompt_install_fedora() {
    local PACKAGES='libxcrypt-compat'

    $ECHO "${CLR_SUCCESS}installing $PACKAGES...${CLR_CLEAR}"
    sudo dnf install -y ${PACKAGES}

    . "$AM_PROMPT/sh/install/centos.sh"
}

__am_prompt_install_fedora
