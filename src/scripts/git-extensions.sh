#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'git-extensions'
fi

git-flow-clone() {
    if ! type git 1>/dev/null 2>&1; then
        echo 'git-clone: git is not available on the current path.'
        return
    fi

    local URL=$1
    local NAME=$2

    if [ -z ${URL:-} ]; then
        echo 'git-clone: you must specify a url, which is the first parameter.'
        return
    fi

    if [ -z ${NAME:-} ]; then
        echo 'git-clone: you must specify a directory name, which is the second parameter.'
        return
    fi

    git clone "$URL" "$NAME" && \
    cd "$NAME" && \
    git branch -a | sed -n "/\/HEAD /d; /\/master$/d; /\/develop$/d; /remotes/p;" | xargs -L1 git checkout -t 2>/dev/null

    echo Checking out master and develop branches...

    git checkout develop 2>/dev/null
    git checkout -b master 2>/dev/null
    git checkout master 2>/dev/null

    git flow init -d 2>/dev/null
}

flow-clone() {
    git-flow-clone $@
}

git-flow-init() {
    if ! type git 1>/dev/null 2>&1; then
        echo 'git-init: git is not available on the current path.'
        return
    fi

    local NAME=$1

    if [ -z ${NAME:-} ]; then
        NAME='.'
    fi

    # initialize a new repo
    git init "$NAME"

    # change directory into the new repo
    cd "$NAME"

    # initialize git flow
    git flow init -d 1>/dev/null

    # create the initial feature
    git flow feature start initial

    local GIT_PATH="$AM_PROMPT/git"

    # copy the default gitignore and gitattributes
    cp "$GIT_PATH/gitignore" .gitignore 1>/dev/null
    cp "$GIT_PATH/gitattributes" .gitattributes 1>/dev/null

    # add the newly created gitignore and gitattributes
    git add source 1>/dev/null

    # create the initial commit
    git commit -m "chore: add git ignore and attributes" 1>/dev/null
}