#! /usr/bin/env sh

set -e

if [ -n "${1:-}" ] && [ -d /repo ]; then
	sudo rm -rf /repo
fi

if command -v apt-get 1>/dev/null 2>&1; then
	sudo apt-get autoremove -y
	sudo rm -rf /var/lib/apt/lists/*
	sudo rm -rf /var/cache/apt
fi

if command -v dnf 1>/dev/null 2>&1; then
	dnf clean all
fi
