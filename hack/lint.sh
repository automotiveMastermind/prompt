#! /usr/bin/env sh

# find all executables not in hidden folders and lint them
find . -name 'Dockerfile*' -type f -print0 \
	| xargs -0 hadolint
