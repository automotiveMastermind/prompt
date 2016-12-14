#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'docker-gc'
fi

function docker-gc() {
    docker-rm
    docker-rmi
}

function docker-rm() {
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
}

function docker-rmi() {
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}