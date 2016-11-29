#!/usr/bin/env bash

if test -n "${PROMPT_DEBUG+1}"; then
    echo 'source-uname'
fi

function source-uname() {
	local unamepath=$HOME/.pulsebridge/prompt/scripts/$(uname)

	if test -d $unamepath; then
		for f in $unamepath/*; do
			source $f
		done
	fi
}

source-uname