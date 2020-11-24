#! /usr/bin/env sh

set -e

./hack/install.sh bash
./hack/install.sh zsh
./hack/test.sh
