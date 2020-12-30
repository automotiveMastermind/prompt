#! /usr/bin/env sh

set -e

SCRIPT_DIR=$(mktemp -d)

cat <<- 'EOT' > $SCRIPT_DIR/e2e.sh
#! /usr/bin/env sh
set -e
./hack/pre.apt.sh
gosu build ./hack/install.sh bash
gosu build ./hack/install.sh zsh
gosu build ./hack/test.sh
EOT

chmod +x $SCRIPT_DIR/e2e.sh

docker run \
    --volume "$PWD":'/repo' \
    --volume "$SCRIPT_DIR":'/scripts' \
    --workdir /repo \
    --tty \
    debian '/scripts/e2e.sh'
