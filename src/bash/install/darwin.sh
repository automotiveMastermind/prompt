#!/usr/bin/env sh

__am_prompt_install_darwin() {
    local BREWS='bash bash-completion'

    set +e

    for pkg in $BREWS; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            $ECHO "${CLR_SUCCESS}upgrading: $pkg...${CLR_CLEAR}"
            brew upgrade $pkg 2>/dev/null
            brew link --overwrite $pkg 2>/dev/null
        else
            $ECHO "${CLR_SUCCESS}installing: $pkg...${CLR_CLEAR}"
            brew install $pkg
        fi
    done
}

__am_prompt_install_darwin
