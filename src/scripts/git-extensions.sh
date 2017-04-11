#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'git-extensions'
fi

git-clone() {
    if ! type git 1>/dev/null 2>&1; then
        echo 'git-clone: git is not available on the current path.'
        return
    fi

    local url=$1
    local name=$2

    if [ -z "${url:-}" ]; then
        echo 'git-clone: you must specify a url, which is the first parameter.'
        return
    fi

    if [ -z "${name:-}" ]; then
        echo 'git-clone: you must specify a directory name, which is the second parameter.'
        return
    fi

    git clone "$url" "$name" && \
    cd "$name" && \
    git branch -a | sed -n "/\/HEAD /d; /\/master$/d; /\/develop$/d; /remotes/p;" | xargs -L1 git checkout -t 2>/dev/null

    echo Checking out master and develop branches...

    git checkout develop 2>/dev/null
    git checkout -b master 2>/dev/null
    git checkout master 2>/dev/null

    git flow init -d 2>/dev/null
}

clone() {
    git-clone $@
}

git-init() {
    if ! type git 1>/dev/null 2>&1; then
        echo 'git-init: git is not available on the current path.'
        return
    fi

    local name=$1

    if [ -z "${name:-}" ]; then
        name='.'
    fi

    # initialize a new repo
    git init "$name"

    # change directory into the new repo
    cd "$name"

    # initialize git flow
    git flow init -d 1>/dev/null

    # create the initial feature
    git flow feature start initial

    local gitpath="$AM_PROMPT/git"

    # copy the default gitignore and gitattributes
    cp "$gitpath/gitignore" .gitignore 1>/dev/null
    cp "$gitpath/gitattributes" .gitattributes 1>/dev/null

    # add the newly created gitignore and gitattributes
    git add source 1>/dev/null

    # create the initial commit
    git commit -m "chore: add git ignore and attributes" 1>/dev/null
}