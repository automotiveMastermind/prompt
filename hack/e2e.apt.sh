#! /usr/bin/env sh

set -e

SCRIPT_DIR=$(mktemp -d)

cat <<- 'EOT' > $SCRIPT_DIR.e2e.sh
#! /usr/bin/env sh
set -e
./hack/pre.apt.sh
./hack/install.sh bash
./hack/install.sh zsh
./hack/test.sh
EOT

chmod +x $SCRIPT_DIR/e2e.sh

docker run \
    --volume $PWD:/home/build
    --volume $SCRIPT_DIR:/build \
    debian --tty 'sh -c /build/e2e.sh'
