#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
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