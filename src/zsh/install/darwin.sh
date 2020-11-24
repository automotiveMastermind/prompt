#!/usr/bin/env sh

__am_prompt_install_darwin() {
    local BREWS='zsh'

    set +e

    for pkg in $BREWS; do
        if brew list --formula -1 | grep -q "^${pkg}\$"; then
            $ECHO "${CLR_SUCCESS}upgrading: $pkg...${CLR_CLEAR}"
            brew upgrade $pkg 2>/dev/null
            brew link --overwrite $pkg 2>/dev/null
        else
            $ECHO "${CLR_SUCCESS}installing: $pkg...${CLR_CLEAR}"
            brew install $pkg
        fi
    done

    # set permissions on the site-functions paths
    sudo chmod u=rwx,go=rx "$LOCAL_PREFIX/share/zsh"
    sudo chown $(whoami) "$LOCAL_PREFIX/share/zsh"

    sudo chmod u=rwx,go=rx "$LOCAL_PREFIX/share/zsh/site-functions"
    sudo chown $(whoami) "$LOCAL_PREFIX/share/zsh/site-functions"

    # test to see if the zsh completion dir is specified
    if [ ! -z "${ZSH_COMPLETION_DIR:-}" ]; then

        # set permissions on the script directory
        sudo chmod u=rwx,go=rx $ZSH_COMPLETION_DIR
        sudo chown $(whoami) $ZSH_COMPLETION_DIR
    fi
}

__am_prompt_install_darwin
