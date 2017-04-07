#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'update-sln'
fi

function update-sln() {
    rm -rf *.sln 1>/dev/null
    dotnet new sln
    find . -name *.csproj | xargs dotnet sln add
}