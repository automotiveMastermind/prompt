#!/usr/bin/env sh

set -eu

printf "%s\n" "test default install"
./src/sh/scripts/install-dotnet

printf "%s\n" "test channel install"
./src/sh/scripts/install-dotnet --channel lts

printf "%s\n" "test version install"
./src/sh/scripts/install-dotnet --version latest
