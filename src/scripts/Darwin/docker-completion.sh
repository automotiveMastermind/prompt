#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'docker-completion'
fi

__prompt-docker-completion() {
    if [ -d /Applications/Docker.app/Contents/Resources/etc ]; then
        local DOCKER_PATH=/Applications/Docker.app/Contents/Resources/etc
    elif [ -d "$HOME/Applications/Docker.app/Contents/Resources/etc" ]; then
        local DOCKER_PATH="$HOME/Applications/Docker.app/Contents/Resources/etc"
    fi

    if [ ! -z "${DOCKER_PATH:-}" ]; then
        source "$DOCKER_PATH/docker.bash-completion"
        source "$DOCKER_PATH/docker-machine.bash-completion"
        source "$DOCKER_PATH/docker-compose.bash-completion"
    fi
}

__prompt-docker-completion