#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo "dotnet-install"
fi

safe-exec() {
    local CMD=$1
    shift

    $CMD "$@" 2>&1

    local EXIT_CODE=$?

    if [ $EXIT_CODE -ne 0 ]; then
        return $EXIT_CODE
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
    local DOTNET_RESET=0

    # continue testing for arguments
    while [[ $# > 0 ]]; do
        case $1 in
            --reset|--clean)
                DOTNET_RESET=1
                ;;
            --)
                shift
                break
                ;;
            *)
                export DOTNET_INSTALL_DIR=$1
                break
                ;;
        esac
        shift
    done

    if [ -z "${DOTNET_INSTALL_DIR:-}" ]; then
        export DOTNET_INSTALL_DIR=$HOME/.dotnet
    fi

    if [[ "$DOTNET_RESET" == "1" ]]; then
        rm -rf $DOTNET_INSTALL_DIR
    fi

    if [ ! -d $DOTNET_INSTALL_DIR ]; then
        mkdir -p $DOTNET_INSTALL_DIR
    fi

    local DOTNET_INSTALL_SH="$DOTNET_INSTALL_DIR/dotnet-install.sh"
    local DOTNET_PROJECTJSON_URI="https://raw.githubusercontent.com/dotnet/cli/rel/1.0.0-preview2.1/scripts/obtain/dotnet-install.sh"
    local DOTNET_MSBUILD_URI="https://raw.githubusercontent.com/dotnet/cli/rel/1.0.0/scripts/obtain/dotnet-install.sh"
    local DOTNET_MSBUILD_CHANNELS=("rel-1.0.1")
    local DOTNET_MSBUILD_VERSIONS=("1.0.1")

    curl -fSsL $DOTNET_PROJECTJSON_URI -o $DOTNET_INSTALL_SH 1>/dev/null 2>&1
    safe-exec chmod +x $DOTNET_INSTALL_SH
    safe-exec $DOTNET_INSTALL_SH

    curl -fSsL $DOTNET_MSBUILD_URI -o $DOTNET_INSTALL_SH 1>/dev/null 2>&1
    safe-exec chmod +x $DOTNET_INSTALL_SH

    for DOTNET_MSBUILD_CHANNEL in ${DOTNET_MSBUILD_CHANNELS[@]}; do
        safe-exec $DOTNET_INSTALL_SH --channel $DOTNET_MSBUILD_CHANNEL
    done

    for DOTNET_MSBUILD_VERSION in ${DOTNET_MSBUILD_VERSIONS[@]}; do
        safe-exec $DOTNET_INSTALL_SH --version $DOTNET_MSBUILD_VERSION
    done

    mkdir -p /usr/local/share 1>/dev/null 2>&1
    ln -s $DOTNET_INSTALL_DIR /usr/local/share 1>/dev/null 2>&1
    set-dotnet-path
}

set-dotnet-path