#!/usr/bin/env bash

if test -n "${UBER_DEBUG+1}"; then
    echo 'source-uname'
fi

function source-uname() {
	local unamepath=$HOME/.uber/scripts/$(uname)

	if test -d $unamepath; then
		for f in $unamepath/*; do
			source $f
		done
	fi
}

source-uname