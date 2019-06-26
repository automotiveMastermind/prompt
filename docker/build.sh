#! /usr/bin/env bash

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_DIR=$(dirname "$SCRIPT_DIR")
LOGS_DIR="$REPO_DIR/artifacts/logs"

PLATFORMS=( "$@" )

if [ -z "${PLATFORMS:-}" ]; then
    PLATFORMS=($(basename $SCRIPT_DIR/*/))
fi

mkdir -p "$LOGS_DIR" 1>/dev/null 2>&1

for platform in "${PLATFORMS[@]}"; do
    dockerfile="$SCRIPT_DIR/$platform/Dockerfile"
    tag="prompt:$platform"

    docker build --file "$dockerfile" --tag $tag "$REPO_DIR" | tee "$LOGS_DIR/$platform.log"
done
