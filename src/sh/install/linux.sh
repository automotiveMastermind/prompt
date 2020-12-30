#!/usr/bin/env sh

set -e

__am_prompt_install_linux() {

    local BREWS='gcc git gpg starship gh nvm'

    if ! type brew 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        bash -c "CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) || true"

        . "$AM_PROMPT/sh/scripts/eval/set-brew-path"

        # disable brew analytics
        brew analytics off
    fi

    $ECHO "${CLR_SUCCESS}updating homebrew...${CLR_CLEAR}"
    brew update

    set +e

    for pkg in $BREWS; do
        if brew list --versions "$pkg" 1>/dev/null; then
            $ECHO "${CLR_SUCCESS}upgrading: $pkg...${CLR_CLEAR}"
            brew upgrade $pkg 2>/dev/null
            brew link --overwrite $pkg 2>/dev/null
        else
            $ECHO "${CLR_SUCCESS}installing: $pkg...${CLR_CLEAR}"
            brew install $pkg
        fi
    done

    # make sure we have ownership of linuxbrew
    sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew

    $ECHO "${CLR_SUCCESS}upgrading: fira code font...${CLR_CLEAR}"

    # setup the font dir
    FONT_DIR="$HOME/.local/share/fonts/NerdFonts"

    # create a temp dir for fonts
    TEMP_DIR=$(mktemp -d)

    # download fonts
    curl -sLo "$TEMP_DIR/FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

    # determine if fira code already exists
    if [ -d "$FONT_DIR" ]; then

        # delete fira code
        rm -rf "$FONT_DIR" 1>/dev/null 2>&1
    fi

    # make sure the font dir exists
    mkdir -p $FONT_DIR 1>/dev/null

    # extract fira code
    unzip "$TEMP_DIR/FiraCode.zip" 'Fira*.otf' -x '*Windows*' -d "$FONT_DIR" 1>/dev/null

    # remove temp
    rm -rf $TEMP_DIR 1>/dev/null 2>&1
}

__am_prompt_install_linux
