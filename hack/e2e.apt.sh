#! /usr/bin/env sh

set -e

./hack/pre.apt.sh
gosu build ./hack/e2e.sh
