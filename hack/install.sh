#! /usr/bin/env sh

set -e

SHELL_NAME=${1:-'bash'}

./install.sh "$SHELL_NAME"

SHELL=$SHELL_NAME

if [ -f /opt/homebrew/bin/"$SHELL_NAME" ]; then
	SHELL=/opt/homebrew/bin/$SHELL_NAME
elif [ -f /usr/local/bin/"$SHELL_NAME" ]; then
	SHELL=/usr/local/bin/${SHELL_NAME}
elif [ -f /home/linuxbrew/.linuxbrew/bin/"$SHELL_NAME" ]; then
	SHELL=/home/linuxbrew/.linuxbrew/bin/${SHELL_NAME}
fi

# this is done on purpose to make sure that $AM_PROMPT is evaluated from
# the successful loading of the login shell and shell profile
# shellcheck disable=SC2016
$SHELL -lc 'cat $AM_PROMPT/.sha'
