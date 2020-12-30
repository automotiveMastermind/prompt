#! /usr/bin/env sh

set -e

uname=$(uname | tr '[:upper:]' '[:lower:]')

if [ "$uname" != "darwin" ]; then
    echo "This must be run on macOS!"
fi

./hack/install.sh bash
./hack/install.sh zsh
./hack/test.sh
