#! /usr/bin/env sh

final=0

SHELL_NAME=${1:-'bash'}
SHELL=$SHELL_NAME

if [ -f /opt/homebrew/bin/"$SHELL_NAME" ]; then
	SHELL=/opt/homebrew/bin/$SHELL_NAME
elif [ -f /usr/local/bin/"$SHELL_NAME" ]; then
	SHELL=/usr/local/bin/${SHELL_NAME}
elif [ -f /home/linuxbrew/.linuxbrew/bin/"$SHELL_NAME" ]; then
	SHELL=/home/linuxbrew/.linuxbrew/bin/${SHELL_NAME}
fi

set +e

for test in ./test/sh/scripts/*.test.sh; do
	TERM=dumb $SHELL -lc "$test"
	exit_code=$?

    if [ $exit_code -ne 0 ]; then
		name=$(basename "$test")
		printf "%s\n" "test ($name) failed: $exit_code"
		final=1
	fi
done

exit $final
