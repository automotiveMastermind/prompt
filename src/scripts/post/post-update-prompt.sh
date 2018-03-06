#!/usr/bin/env bash

if [ "${AM_PROMPT_UPDATE}" == "1" ]; then
    update-prompt
fi

if [ "${AM_PROMPT_UPDATE}" == "true" ]; then
    update-prompt
fi