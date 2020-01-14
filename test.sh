#!/usr/bin/env sh

set -eu

# run the tests with a dummy terminal
TERM=dumb find ./test/sh/scripts -name '*.test.sh' -exec {} \;
