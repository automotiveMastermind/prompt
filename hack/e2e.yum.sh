#! /usr/bin/env sh

set -e

./hack/pre.yum.sh
gosu build ./hack/e2e.sh
