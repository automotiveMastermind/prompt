#!/usr/bin/env sh

__am_prompt_install_darwin() {
    local BREWS='openssl git go nvm python'

    if ! type brew 1>/dev/null 2>&1; then
        $ECHO "${CLR_SUCCESS}installing homebrew...${CLR_CLEAR}"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    $ECHO "${CLR_SUCCESS}updating homebrew...${CLR_CLEAR}"
    brew update

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

    local NVM_PATH=$(brew --prefix nvm)

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

__am_prompt_install_darwin
