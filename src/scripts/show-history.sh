#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-history'
fi

show-history() {
	history $@
}