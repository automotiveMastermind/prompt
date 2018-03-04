#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'dotnet-install'
fi

__prompt-safe-exec() {
    local CMD=$1
    shift

    $CMD "$@" 2>&1

    local EXIT_CODE=$?

    if [ $EXIT_CODE -ne 0 ]; then
        return $EXIT_CODE
    fi
}

__prompt-set-dotnet-path() {
    if [ -e /usr/local/share/dotnet ]; then
        export PATH=/usr/local/share/dotnet:$PATH
    fi

    if [ -e $HOME/.dotnet/dotnet ]; then
        export PATH=$HOME/.dotnet:$PATH
    fi
}

dotnet-install() {
    local DOTNET_RESET=0
    local DOTNET_CHANNELS=()
    local DOTNET_VERSIONS=()

    # continue testing for arguments
    while [[ $# > 0 ]]; do
        case $1 in
            --reset|--clean)
                DOTNET_RESET=1
                ;;
            --channel)
                DOTNET_CHANNELS+=($2)
                shift
                ;;
            --version)
                DOTNET_VERSIONS+=($2)
                shift
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

    if [ -z ${DOTNET_INSTALL_DIR+x} ]; then
        export DOTNET_INSTALL_DIR=$HOME/.dotnet
    fi

    if [ ${#DOTNET_CHANNELS[@]} -eq 0 ]; then
        DOTNET_CHANNELS=('1.1' '2.0')
    fi

    if [[ "$DOTNET_RESET" == "1" ]]; then
        rm -rf $DOTNET_INSTALL_DIR
    fi

    if [ ! -d $DOTNET_INSTALL_DIR ]; then
        mkdir -p $DOTNET_INSTALL_DIR
    fi

    local DOTNET_INSTALL_SH="$DOTNET_INSTALL_DIR/dotnet-install.sh"
    local DOTNET_CACHE_DIR="$DOTNET_INSTALL_DIR/.cache"

    local DOTNET_URI='https://dot.net/v1/dotnet-install.sh'

    curl -fSsL $DOTNET_URI -o $DOTNET_INSTALL_SH 1>/dev/null 2>&1
    __prompt-safe-exec chmod +x $DOTNET_INSTALL_SH

    for DOTNET_VERSION in ${DOTNET_VERSIONS[@]}; do
        __prompt-safe-exec $DOTNET_INSTALL_SH --version $DOTNET_VERSION
    done

    for DOTNET_CHANNEL in ${DOTNET_CHANNELS[@]}; do
        __prompt-safe-exec $DOTNET_INSTALL_SH --channel $DOTNET_CHANNEL
    done

    mkdir -p /usr/local/share 1>/dev/null 2>&1
    ln -s $DOTNET_INSTALL_DIR /usr/local/share 1>/dev/null 2>&1

    echo "building dotnet cache... (this may take a few minutes)"
    mkdir -p $DOTNET_CACHE_DIR 1>/dev/null 2>&1
    pushd $DOTNET_CACHE_DIR 1>/dev/null
    dotnet new console 1>/dev/null
    dotnet restore 1>/dev/null 2>/dev/null
    popd 1>/dev/null
    rm -rf $DOTNET_CACHE_DIR 1>/dev/null

    __prompt-set-dotnet-path
}

__prompt-set-dotnet-path