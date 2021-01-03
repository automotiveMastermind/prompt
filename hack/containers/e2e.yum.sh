#! /usr/bin/env sh

set -e

IMAGE=${1:-centos}

# remove the container if it already exists
docker rm --force e2e.yum 2>/dev/null || true

# start the container to do nothing
docker run \
	--volume "$PWD":'/repo' \
	--workdir /repo \
	--name e2e.yum \
	--detach \
	--rm \
	--tty \
	"$IMAGE" tail -f /dev/null

# run the e2e script
docker exec --tty e2e.yum './hack/e2e.yum.sh'

# kill the container (if we were successful in e2e)
docker kill e2e.yum
