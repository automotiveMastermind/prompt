#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'dotnet-install'
fi

safe-exec() {
    local CMD=$1
    shift

    $CMD "$@" 2>&1

    local EXIT_CODE=$?

    if [ $EXIT_CODE -ne 0 ]; then
        exit $EXIT_CODE
    fi
}

function set-dotnet-path() {
    if [ -e /usr/local/share/dotnet ]; then
        export PATH=/usr/local/share/dotnet:$PATH
    fi

    if [ -e $HOME/.dotnet/dotnet ]; then
        export PATH=$HOME/.dotnet:$PATH
    fi
}

function dotnet-install() {
    if type dotnet 1>/dev/null 2>&1; then
        return
    fi

    if [ ! -z "${1:-}" ]; then
        export DOTNET_INSTALL_DIR=$1
    fi

    if [ -z "${DOTNET_INSTALL_DIR:-}" ]; then
        export DOTNET_INSTALL_DIR=$HOME/.dotnet
    fi

    local DOTNET_URI=https://raw.githubusercontent.com/dotnet/cli/rel/1.0.0-preview2.1/scripts/obtain/dotnet-install.sh
    local DOTNET_INSTALL_SH=$DOTNET_INSTALL_DIR/dotnet-install.sh

    if [ ! -d $DOTNET_INSTALL_DIR ]; then
        mkdir -p $DOTNET_INSTALL_DIR
    fi

    curl -fSsL $DOTNET_URI -o $DOTNET_INSTALL_SH 1>/dev/null 2>&1

    safe-exec chmod +x $DOTNET_INSTALL_SH
    safe-exec $DOTNET_INSTALL_SH
    safe-exec rm -rf $DOTNET_INSTALL_SH

    mkdir -p /usr/local/share 1>/dev/null 2>&1
    ln -s $DOTNET_INSTALL_DIR /usr/local/share 1>/dev/null 2>&1
    set-dotnet-path
}

set-dotnet-path