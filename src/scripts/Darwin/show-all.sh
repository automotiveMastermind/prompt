#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'show-all'
fi

show-all() {
	defaults write com.apple.finder AppleShowAllFiles TRUE
	killall Finder
}
