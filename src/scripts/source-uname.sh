#!/usr/bin/env bash

function source-uname() {
	local unamepath=~/.ssh/scripts/$(uname)
	
	if test -d $unamepath; then
		for f in $unamepath/*; do
			source $f
		done
	fi
}

source-uname