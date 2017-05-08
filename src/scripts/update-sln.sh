#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'update-sln'
fi

update-sln() {
    rm -rf *.sln 1>/dev/null
    dotnet new sln
    find . -name *.csproj | xargs dotnet sln add
}