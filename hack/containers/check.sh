#! /usr/bin/env sh

set -e

IMAGE=${1:-"koalaman/shellcheck-alpine:stable"}
CONTAINER_NAME=${2:-prompt-lint}

# remove the container if it already exists
docker rm --force "$CONTAINER_NAME" 2>/dev/null || true

# start the container to do nothing
docker run \
	--volume "$PWD":'/repo' \
	--workdir /repo \
	--name "$CONTAINER_NAME" \
	--rm \
	--tty \
	"$IMAGE" './hack/check.sh'
