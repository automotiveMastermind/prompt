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
    $ECHO "  Apple Silicon is not yet officially supported by homebrew. We will install  "
    $ECHO "  homebrew in the following locations:                                        "
    $ECHO "    - /opt/homebrew : arm64e native (DEFAULT)                                 "
    $ECHO "    - /usr/local    : x86_64 emulation via Rosetta 2                          "
    $ECHO
    $ECHO "  The Apple Silicon (arm64e) version will be the default as it will be placed "
    $ECHO "  on the PATH variable before the native version. This is compatible with more"
    $ECHO "  formulae at this time. To use the intel (x86_64) version, you can use the   "
    $ECHO "  \`brew-intel\` alias. For example:                                          "
    $ECHO
    $ECHO "  brew-intel install git                                                      "
    $ECHO
    $ECHO "  NOTE: Installation will take significantly longer as most formulae will be  "
    $ECHO "        built from source. NOT ALL FORMULA ARE GAURANTEED TO WORK. INCLUDING  "
    $ECHO "        THOSE WE ATTEMPT TO INSTALL BY DEFAULT WITHIN PROMPT! We do this to   "
    $ECHO "        enable these formulae via install as soon as they start working.      "
    $ECHO
    $ECHO "##############################################################################"
    $ECHO ${CLR_CLEAR}

    # install rosetta 2
    softwareupdate --install-rosetta --agree-to-license 2>/dev/null

    # create the homebrew directory
    if [ ! -d "/opt/homebrew" ]; then

        # create the homebrew path
        sudo mkdir -p /opt/homebrew

        # chown the path
        sudo chown /opt/homebrew $(whoami):staff
    fi

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

    if ! type "${BREW_CMD}" 1>/dev/null 2>&1; then
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

    if ! type "${BREW_CMD}" 1>/dev/null 2>&1; then
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

    if ! type "${BREW_CMD}" 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        arch -x86_64 /bin/bash -c "HOMEBREW_PREFIX=/opt/homebrew CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && /opt/homebrew/bin/brew config"
    fi

    __am_prompt_install_darwin "arch -arm64e /opt/homebrew/bin/brew"
}

__am_prompt_install_darwin() {
    local BREWS='openssl git go nvm python gpg pinentry-mac'
    local BREW_CMD=${1:-"/usr/local/bin/brew"}

    $ECHO "${CLR_SUCCESS}updating homebrew...${CLR_CLEAR}"
    ${BREW_CMD} update

    set +e

    for pkg in $BREWS; do
        if ${BREW_CMD} list --formula -1 | grep -q "^${pkg}\$"; then
            $ECHO "${CLR_SUCCESS}upgrading: $pkg...${CLR_CLEAR}"
            ${BREW_CMD} upgrade $pkg 2>/dev/null
            ${BREW_CMD} link --overwrite $pkg 2>/dev/null
        else
            $ECHO "${CLR_SUCCESS}installing: $pkg...${CLR_CLEAR}"
            ${BREW_CMD} install $pkg
        fi
    done

    local NVM_PATH=$(${BREW_CMD} --prefix nvm)

    if [ -f "$NVM_PATH/nvm.sh" ]; then
        $ECHO "${CLR_SUCCESS}setting up nvm...${CLR_CLEAR}"
        export NVM_DIR="${HOME}/.nvm"
        . "$NVM_PATH/nvm.sh"
        nvm install --lts 2>/dev/null
        nvm use --lts --delete-prefix --silent 2>/dev/null
    fi

    $ECHO "${CLR_SUCCESS}setting git credential helper to use the macOS keychain${CLR_CLEAR}"
    git config --system credential.helper osxkeychain
}

__am_prompt_ensure_rosetta
