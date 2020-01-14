#!/usr/bin/env sh

set -eux

find ./test/sh/scripts -name '*.test.sh' -exec {} \;
