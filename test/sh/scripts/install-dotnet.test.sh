#!/usr/bin/env sh

set -eu

echo 'test default install'
./src/sh/scripts/install-dotnet

echo 'test channel install'
./src/sh/scripts/install-dotnet --channel lts

echo 'test version install'
./src/sh/scripts/install-dotnet --version latest
