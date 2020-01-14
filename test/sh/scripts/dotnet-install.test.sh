#!/usr/bin/env sh

set -eux

echo 'test default install'
./src/sh/scripts/dotnet-install

echo 'test channel install'
./src/sh/scripts/dotnet-install --channel lts

echo 'test version install'
./src/sh/scripts/dotnet-install --version latest

