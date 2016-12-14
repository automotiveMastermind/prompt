#!/usr/bin/env bash

function prompt-bootstrap()
{
    local CURL_OPT='-s'
    if [ ! -z "${GH_TOKEN:-}" ]; then
        CURL_OPT='$CURL_OPT -H "Authorization: token $GH_TOKEN"'
    fi

    local SHA_URI="https://api.github.com/repos/pulsebridge/prompt/commits/master"
    local PROMPT_SHA=$(curl $CURL_OPT $SHA_URI | grep sha | head -n 1 | sed 's#.*\:.*"\(.*\).*",#\1#')
    local SHA_PATH=$HOME/.pulsebridge/prompt/$PROMPT_SHA

    if [ -f $SHA_PATH ]; then
        echo "prompt: latest version already installed: $PROMPT_SHA"
        exit 0
    fi

    local INSTALL_URI="https://github.com/pulsebridge/prompt/archive/master.tar.gz"
    local INTALL_TEMP=$(mktemp -d -t pb_prompt)
    local EXTRACT_TEMP="$INTALL_TEMP/extract"

    pushd $INTALL_TEMP 1>/dev/null
    curl -skL $INSTALL_URI | tar zx
    pushd prompt-master 1>/dev/null
    ./install.sh
    popd 1>/dev/null
    popd 1>/dev/null

    rm -rf $INTALL_TEMP 1>/dev/null
}

prompt-bootstrap