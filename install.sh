#!/usr/bin/env bash

CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

PULSEBRIDGE_PATH="$HOME/.pulsebridge"
PULSEBRIDGE_PROMPT="$HOME/.pulsebridge/prompt"

function success() {
    echo -e "${CLR_SUCCESS}$1${CLR_CLEAR}"
}

now=$(date +"%Y%m%d_%H%M%S")
backup_path="$PULSEBRIDGE_PATH/backup/prompt/$now"

success "Creating backup path : $backup_path..."
mkdir -p "$backup_path" 1>/dev/null

if [ -d $PULSEBRIDGE_PROMPT ]; then
    success "Backing up $PULSEBRIDGE_PROMPT..."
    cp -R $PULSEBRIDGE_PROMPT/* "$backup_path" 1>/dev/null

    success "Removing $PULSEBRIDGE_PROMPT..."
    rm -rf $PULSEBRIDGE_PROMPT 1>/dev/null
fi

success "Creating $PULSEBRIDGE_PROMPT..."
mkdir -p $PULSEBRIDGE_PROMPT/bin 1>/dev/null

success "Installing PulseBridge Prompt to $PULSEBRIDGE_PROMPT..."
cp -Rf src/* $PULSEBRIDGE_PROMPT 1>/dev/null

if [ -f $backup_path/scripts/bookmarks.sh ]; then
    success "Restoring bookmarks..."
    cp -R $backup_path/scripts/bookmarks.sh $PULSEBRIDGE_PROMPT/scripts 1>/dev/null
fi

if [ -f $backup_path/scripts/variables.sh ]; then
    success "Restoring variables..."
    cp -R $backup_path/scripts/variables.sh $PULSEBRIDGE_PROMPT/scripts 1>/dev/null
fi

for template in template/*; do
    name=$(basename "$template")
    path=$HOME/.${name}

    if [ -f $path ]; then
        success "Backing up ${name}..."
        cp $path $backup_path/$name
    fi

    cat $template > $path
done

LOCAL_PREFIX=/usr/local
BASH_COMPLETION=$LOCAL_PREFIX/etc/bash_completion.d
UNAME=$(uname)
UNAME_INSTALL="./uname/install-$UNAME.sh"

if [ -e /etc/os-release ]; then
    . /etc/os-release

    UNAME_INSTALL="./uname/install-$ID.sh"
fi

if [ -f $UNAME_INSTALL ]; then
    source $UNAME_INSTALL
fi

GIT_PROMPT_NAME=git-prompt.sh
GIT_COMPLETE_NAME=git-flow-completion.bash
GIT_PROMPT_URI=https://raw.githubusercontent.com/lyze/posh-git-sh/master/$GIT_PROMPT_NAME
GIT_COMPLETE_URI=https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/$GIT_COMPLETE_NAME
PROMPT_COMPLETION=$PULSEBRIDGE_PROMPT/completions

if [ -f "$BASH_COMPLETION/$GIT_COMPLETE_NAME" ]; then
    success "Removing git flow bash completion..."
    sudo rm -rf "$BASH_COMPLETION/$GIT_COMPLETE_NAME" 1>/dev/null
fi

if [ -f "$BASH_COMPLETION/$GIT_PROMPT_NAME" ]; then
    success "Removing crappy git-prompt..."
    sudo rm -rf "$BASH_COMPLETION/$GIT_PROMPT_NAME" 1>/dev/null
fi

if [ ! -d "$PROMPT_COMPLETION" ]; then
    mkdir -p "$PROMPT_COMPLETION" 1>/dev/null
fi

success "Downloading better git-prompt..."
result=$(curl -sLD- "$GIT_PROMPT_URI" -o "$PROMPT_COMPLETION/$GIT_PROMPT_NAME" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

if [ "$result" = "200" ]; then
    success "Successfully installed git-prompt..."
    chmod +x "PROMPT_COMPLETION/$GIT_PROMPT_NAME" 1>/dev/null 2>&1
fi

success "Downloading git-flow completion..."
result=$(curl -sLD- "$GIT_COMPLETE_URI" -o "$PROMPT_COMPLETION/$GIT_COMPLETE_NAME" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

if [ "$result" = "200" ]; then
    success "Successfully installed git-flow completion..."
    chmod +x "$PROMPT_COMPLETION/$GIT_COMPLETE_NAME" 1>/dev/null 2>&1
fi

SHA=$(git rev-parse HEAD)
SHA_PATH=$PULSEBRIDGE_PROMPT/$SHA

touch $SHA_PATH 1>/dev/null 2>&1

echo -e "${CLR_SUCCESS}"
echo "#######################################"
echo "#######################################"
echo "   PLEASE OPEN A NEW TERMINAL WINDOW"
echo "#######################################"
echo "#######################################"
echo -e "${CLR_CLEAR}"