#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'show-all'
fi
function show-all() {
	defaults write com.apple.finder AppleShowAllFiles TRUE
	killall Finder
}
