#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'gcloud-install'
fi

__prompt-set-gcloud-path() {
    if [ -e $HOME/.gcloud/bin/gcloud ]; then
        export PATH=$PATH:~/.gcloud/bin
    fi
}

gcloud-install() {
    local GCLOUD_PATH=$HOME/.gcloud
    local PLATFORM='linux'

    if [ "$(uname)" == "Darwin" ]; then
        PLATFORM='darwin'
    fi

    local URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-161.0.0-$PLATFORM-x86_64.tar.gz

    local TEMP=$(mktemp -d)
    local FILENAME=$TEMP/gcloud-sdk.tar.gz
    local EXPANDED=$TEMP/google-cloud-sdk

    if ! type gcloud 1>/dev/null 2>&1; then

        echo
        echo "downloading gcloud-sdk"
        curl -L $URL -o $FILENAME --silent 2>&1

        tar -xf $FILENAME -C $TEMP 1>/dev/null 2>&1

        rm -rf $GCLOUD_PATH 1>/dev/null 2>&1
        mv $EXPANDED $GCLOUD_PATH 1>/dev/null 2>&1
        rm -rf $TEMP 1>/dev/null 2>&1

        echo
        echo "installing gcloud-sdk"
        ~/.gcloud/install.sh --command-completion false --usage-reporting false --quiet --path-update false 2>&1

        __prompt-set-gcloud-path
    fi

    echo
    echo "installing and updating gcloud components"
    gcloud components install kubectl docker-credential-gcr gsutil core --quiet 2>&1
    gcloud components update --quiet 2>&1
}

__prompt-set-gcloud-path