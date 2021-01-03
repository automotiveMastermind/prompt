#! /usr/bin/env sh

set -eu

printf "%s\n" "test gpg-agent"
./src/sh/scripts/eval/set-gpg-agent
