#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'post-set-prompt'
fi

# set the prompt
__prompt-set-prompt
