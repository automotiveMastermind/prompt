#! /usr/bin/env sh

# find all executables not in hidden folders and lint them
find . -not -path './.*/*' -type f -perm +ugo+x -print0 \
	| xargs -0 shellcheck -e SC1090,SC1091,SC1071
