#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'flush-dns'
fi

function flush-dns() {
	dscacheutil -flushcache
	sudo killall -HUP mDNSResponder
}

function flushdns() {
	flush-dns
}
