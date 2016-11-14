#!/usr/bin/env bash

CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

function success() {
    echo -e "${CLR_SUCCESS}$1${CLR_CLEAR}"
}

now=$(date +"%Y%m%d_%H%M%S")
backup_path="backup/$now"

success "Creating backup path : $pwd/backup/$now..."
mkdir -p "backup/$now" 1>/dev/null

if test -d ~/.uber; then
    success "Backing up ~/.uber..."
    cp -R ~/.uber/* "backup/$now" 1>/dev/null

    success "Removing ~/.uber..."
    rm -rf ~/.uber 1>/dev/null
fi

success "Creating ~/.uber..."
mkdir -p ~/.uber 1>/dev/null

success "Installing uber to ~/.uber..."
cp -Rf src/* ~/.uber 1>/dev/null

if test -f $backup_path/scripts/bookmarks.sh; then
    success "Restoring bookmarks..."
    cp -R $backup_path/uber/scripts/bookmarks.sh ~/.uber/scripts 1>/dev/null
fi

for template in template/*; do
    name=$(basename "$template")
    path=$HOME/.${name}

    if test -f $path; then
        success "Backing up ${name}..."
        cp $path $backup_path/$name
    fi

    cat $template > $path
done

LOCAL_PREFIX=/usr/local
BASH_COMPLETION=$LOCAL_PREFIX/etc/bash_completion.d
UNAME=$(uname)

if test "$UNAME" = "Darwin"; then
    if ! type brew 1>/dev/null 2>&1; then
        success "Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    LOCAL_PREFIX=$(brew --prefix)

    success "Updating Homebrew..."
    brew update 1>/dev/null

    for pkg in git-flow; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            success "Uninstalling $pkg..."
            brew uninstall ${pkg} 1>/dev/null 2>&1
        fi
    done

    for pkg in openssl git git-extras git-flow-avh nvm; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            success "Upgrading $pkg..."
            brew upgrade ${pkg} 1>/dev/null 2>&1
            brew link --overwrite ${pkg} 1>/dev/null 2>&1
        else
            success "Installing $pkg..."
            brew install ${pkg} 1>/dev/null 2>&1
        fi
    done

    nvm_path=$(brew --prefix nvm)

    if test -d $nvm_path; then
        if ! test -d $HOME/.nvm; then
            mkdir -p $HOME/.nvm
        fi

        export NVM_DIR=~/.nvm

        . $nvm_path/nvm.sh

        nvm use --lts 1>/dev/null
    fi

    success "Setting git credential helper to use the macOS keychain..."
    git config --system credential.helper osxkeychain 1>/dev/null
fi

if test "$UNAME" = "Linux"; then
    LOCAL_PREFIX=/usr/share
    BASH_COMPLETION="${LOCAL_PREFIX}/bash-completion/completions"

    sudo add-apt-repository ppa:pdoes/gitflow-avh -y 1>/dev/null 2>&1
    sudo add-apt-repository ppa:git-core/ppa -y 1>/dev/null 2>&1
    sudo apt-get update 1>/dev/null

    for pkg in git-flow; do
        if apt list $pkg | grep -q "&${pkg}(.*)\[installed\]$" 2>/dev/null; then
            sudo apt-get remove -y $pkg 1>/dev/null
        fi
    done

    for pkg in openssl git git-extras git-flow build-essential libssl-dev; do
        success "Installing $pkg..."
        sudo apt-get install -y ${pkg}
    done

    sudo apt-get autoremove -y 1>/dev/null

    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
fi

if test "$UNAME" = "MINGW64_NT-10.0"; then
    LOCAL_PREFIX=$LOCALAPPDATA/git
    BASH_COMPLETION=$LOCAL_PREFIX/etc/bash_completion.d

    mkdir -p "$BASH_COMPLETION" 1>/dev/null
fi

GIT_PROMPT_NAME=git-prompt.sh
GIT_COMPLETE_NAME=git-flow-completion.bash
GIT_PROMPT_URI=https://raw.githubusercontent.com/lyze/posh-git-sh/master/$GIT_PROMPT_NAME
GIT_COMPLETE_URI=https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/$GIT_COMPLETE_NAME
UBER_COMPLETION=~/.uber/completions

if test -f "$BASH_COMPLETION/$GIT_COMPLETE_NAME"; then
    success "Removing git flow bash completion..."
    sudo rm -rf "$BASH_COMPLETION/$GIT_COMPLETE_NAME" 1>/dev/null
fi

if test -f "$BASH_COMPLETION/$GIT_PROMPT_NAME"; then
    success "Removing crappy git-prompt..."
    sudo rm -rf "$BASH_COMPLETION/$GIT_PROMPT_NAME" 1>/dev/null
fi

if ! test -d "$UBER_COMPLETION"; then
    mkdir -p "$UBER_COMPLETION" 1>/dev/null
fi

success "Downloading better git-prompt..."
result=$(curl -s -L -D - "$GIT_PROMPT_URI" -o "$UBER_COMPLETION/$GIT_PROMPT_NAME" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

if test "$result" = "200"; then
    success "Successfully installed git-prompt..."
fi

success "Downloading git-flow completion..."
result=$(curl -s -L -D - "$GIT_COMPLETE_URI" -o "$UBER_COMPLETION/$GIT_COMPLETE_NAME" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

if test "$result" = "200"; then
    success "Successfully installed git-flow completion..."
fi

echo -e "${CLR_SUCCESS}"
echo "#######################################"
echo "#######################################"
echo "   PLEASE OPEN A NEW TERMINAL WINDOW"
echo "#######################################"
echo "#######################################"
echo -e "${CLR_CLEAR}"
