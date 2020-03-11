#!/usr/bin/env sh

__am_prompt_install_darwin() {
    local BREWS='zsh'

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

    # test to see if the zsh completion dir is specified
    if [ ! -z "${ZSH_COMPLETION_DIR:-}" ]; then

        # iterate over each completion
        for completion in $ZSH_COMPLETION_DIR/*; do

            # test for invalid completion
            if [ ! -e $completion ]; then

                # let the user know we're removing the invalid completion
                $ECHO "${CLR_WARN}removing: $completion as it no longer exists...${CLR_CLEAR}"

                # remove the completion
                rm -f $completion
            fi
        done
    fi
}

__am_prompt_install_darwin
