#!/usr/bin/env bash

set -e

__am_prompt_ensure_rosetta() {

    # determine if we are on x86
    if [ "$(uname -m)" = "x86_64" ]; then

        # install homebrew using defaults
        __am_prompt_install_intel

        # move on immediately
        return $?
    fi

    $ECHO ${CLR_WARN}
    $ECHO "##############################################################################"
    $ECHO
    $ECHO "  DETECTED APPLE SILICON                                                      "
    $ECHO
    $ECHO "  Apple Silicon is NOW officially supported by homebrew but some formulae do  "
    $ECHO "  not yet have bottles available, so we will continue to install both apple   "
    $ECHO "  silicon and intel homebrew in the following locations:                      "
    $ECHO "    - /opt/homebrew : arm64e native (DEFAULT)                                 "
    $ECHO "    - /usr/local    : x86_64 emulation via Rosetta 2                          "
    $ECHO
    $ECHO "  The Apple Silicon (arm64e) version will be the default as it will be placed "
    $ECHO "  on the PATH variable before the native version. While this is not compatible"
    $ECHO "  with most formulae, we expect this to improve over time. To use the         "
    $ECHO "  intel (x86_64) version, you can use the \`brew-intel\` alias. For example:  "
    $ECHO
    $ECHO "  brew-intel install git                                                      "
    $ECHO
    $ECHO "##############################################################################"
    $ECHO ${CLR_CLEAR}

     # install homebrew for apple silicon
    __am_prompt_install_arm64

    # install homebrew in rosetta
    __am_prompt_install_rosetta
}

__am_prompt_install_intel() {
    $ECHO ${CLR_SUCCESS}
    $ECHO "##############################################################################"
    $ECHO "INSTALLING VIA HOMEBREW FOR INTEL MACS"
    $ECHO "##############################################################################"
    $ECHO ${CLR_CLEAR}

    HOMEBREW_PREFIX="/usr/local"
    BREW_CMD="$HOMEBREW_PREFIX/bin/brew"

    if ! command -v $BREW_CMD 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        /bin/bash -c "CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && /usr/local/bin/brew config"
    fi

    __am_prompt_install_darwin "/usr/local/bin/brew"
}

__am_prompt_install_rosetta() {
    $ECHO ${CLR_SUCCESS}
    $ECHO "##############################################################################"
    $ECHO "INSTALLING VIA HOMEBREW FOR ROSETTA 2 (x86_64)"
    $ECHO "##############################################################################"
    $ECHO ${CLR_CLEAR}

    # install rosetta 2
    softwareupdate --install-rosetta --agree-to-license 2>/dev/null

    HOMEBREW_PREFIX="/usr/local"
    BREW_CMD="$HOMEBREW_PREFIX/bin/brew"

    if ! command -v $BREW_CMD 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        arch -x86_64 /bin/bash -c "HOMEBREW_PREFIX=/usr/local CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && /usr/local/bin/brew config"
    fi

    __am_prompt_install_darwin "arch -x86_64 /usr/local/bin/brew"
}

__am_prompt_install_arm64() {
    $ECHO ${CLR_SUCCESS}
    $ECHO "##############################################################################"
    $ECHO "INSTALLING VIA HOMEBREW FOR APPLE SILICON (arm64e)"
    $ECHO "##############################################################################"
    $ECHO ${CLR_CLEAR}

    HOMEBREW_PREFIX="/opt/homebrew"
    BREW_CMD="$HOMEBREW_PREFIX/bin/brew"

    if ! command -v $BREW_CMD 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        /bin/bash -c "HOMEBREW_PREFIX=$HOMEBREW_PREFIX CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && $BREW_CMD config"
    fi

    __am_prompt_install_darwin "arch -arm64e /opt/homebrew/bin/brew"
}

__am_prompt_install_darwin() {
    local BREWS='openssl git go nvm python gpg pinentry-mac starship gh'
    local BREW_CMD=${1:-"/usr/local/bin/brew"}

    # disable brew analytics
    $BREW_CMD analytics off

    $ECHO "${CLR_SUCCESS}updating homebrew...${CLR_CLEAR}"
    $BREW_CMD update

    set +e

    for pkg in $BREWS; do
        if $BREW_CMD list --versions "$pkg" 1>/dev/null; then
            $ECHO "${CLR_SUCCESS}upgrading: $pkg...${CLR_CLEAR}"
            $BREW_CMD upgrade $pkg 2>/dev/null
            $BREW_CMD link --overwrite $pkg 2>/dev/null
        else
            $ECHO "${CLR_SUCCESS}installing: $pkg...${CLR_CLEAR}"
            $BREW_CMD install $pkg
        fi
    done

    local NVM_PATH=$($BREW_CMD --prefix nvm)

    if [ -f "$NVM_PATH/nvm.sh" ]; then
        $ECHO "${CLR_SUCCESS}setting up nvm...${CLR_CLEAR}"
        export NVM_DIR="${HOME}/.nvm"
        . "$NVM_PATH/nvm.sh"
    fi

    $ECHO "${CLR_SUCCESS}setting git credential helper to use the macOS keychain${CLR_CLEAR}"
    git config --system credential.helper osxkeychain
}

__am_prompt_install_fonts() {

    # install font
    $ECHO "${CLR_SUCCESS}upgrading: fira code font...${CLR_CLEAR}"

    # setup the font dir
    FONT_DIR="$HOME/Library/Fonts/NerdFonts"

    # create a temp dir for fonts
    TEMP_DIR=$(mktemp -d)

    # download fonts
    curl -sLo "$TEMP_DIR/FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

    # determine if fira code already exists
    if [ -d "$FONT_DIR" ]; then

        # delete fira code
        rm -rf "$FONT_DIR" 1>/dev/null 2>&1
    fi

    # extract fira code
    unzip "$TEMP_DIR/FiraCode.zip" 'Fira*.otf' -x '*Windows*' -d "$FONT_DIR" 1>/dev/null

    # remove temp
    rm -rf $TEMP_DIR 1>/dev/null 2>&1
}

__am_prompt_ensure_rosetta
__am_prompt_install_fonts
