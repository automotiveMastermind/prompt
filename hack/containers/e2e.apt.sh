#! /usr/bin/env sh

set -e

IMAGE=${1:-debian}

# remove the container if it already exists
docker rm --force e2e.apt 2>/dev/null || true

# start the container to do nothing
docker run \
	--volume "$PWD":'/repo' \
	--workdir /repo \
	--name e2e.apt \
	--detach \
	--rm \
	--tty \
	"$IMAGE" tail -f /dev/null

# run the e2e script
docker exec --tty e2e.apt './hack/e2e.apt.sh'

# kill the container (if we were successful in e2e)
docker kill e2e.apt
