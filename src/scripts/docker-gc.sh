#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'docker-gc'
fi

function docker-gc() {
    if type docker 1>/dev/null 2>&1; then
        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc spotify/docker-gc
    fi
}