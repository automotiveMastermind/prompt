#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'git-extras'
fi

git-lines() {
    git summary --line
}

git-commits() {
    git summary
}

git-sha() {
    local ORG_NAME=$1
    local REPO_NAME=$2
    local BRANCH_NAME=$3

    if [ -z ${ORG_NAME:-} ]; then
        ORG_NAME='automotiveMastermind'
    fi

    if [ -z ${REPO_NAME:-} ]; then
        REPO_NAME='prompt'
    fi

    if [ -z ${BRANCH_NAME:-} ]; then
        BRANCH_NAME='master'
    fi

    local CURL_OPT='-s'

    if [ ! -z "${GH_TOKEN:-}" ]; then
        CURL_OPT="$CURL_OPT -H 'Authorization: $GH_TOKEN'"
    fi

    local SHA_URI=https://api.github.com/repos/$ORG_NAME/$REPO_NAME/commits/$BRANCH_NAME
    local SHA=$(curl $CURL_OPT $SHA_URI | grep sha | head -n 1 | sed 's#.*\:.*"\(.*\).*",#\1#')

    if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
        echo "curl $CURL_OPT $SHA_URI"
    fi

    if [ ! -z "${SHA:-}" ]; then
        echo $SHA
        return 0
    fi

    echo "ERROR RETRIEVING GIT SHA FOR $SHA_URI"
    echo "$(curl $CURL_OPT $SHA_URI)"

    return 1
}

git-token() {
    local GH_TOKEN=$1

    if [ -z ${GH_TOKEN:-} ]; then
        echo 'usage: git-token [token]'
    else
        add-var GH_TOKEN $GH_TOKEN
    fi
}