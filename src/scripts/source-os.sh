#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'source-os'
fi

__prompt-source-os() {
    local uname=$(uname)
	local unamepath=$HOME/.am/prompt/scripts/$uname

    if [ -e /etc/os-release ]; then
        source /etc/os-release

        local unamepath=$HOME/.am/prompt/scripts/$ID
    fi

	if [ -d $unamepath ]; then
		for f in $unamepath/*; do
			source $f
		done
	fi
}

__prompt-source-os