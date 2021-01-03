#! /usr/bin/env sh

set -e

# source the colors
SCRIPT_DIR="${2:-$(cd -- "$(dirname -- "$0")" && pwd -P)}"
. "$SCRIPT_DIR"/src/sh/scripts/eval/set-colors

export HOMEBREW_NO_AUTO_UPDATE=1

export AM_HOME="$HOME/.am"
export AM_PROMPT="$AM_HOME/prompt"

__am_prompt_install() {
	NOW=$(date +"%Y%m%d_%H%M%S")
	BACKUP_PATH="$AM_HOME/backup/prompt/$NOW"

	print-success "creating backup path: $BACKUP_PATH"
	mkdir -p "$BACKUP_PATH" 1>/dev/null

	for TEMPLATE in "$SCRIPT_DIR"/template/*; do
		TEMPLATE_NAME=$(basename "$TEMPLATE")
		TEMPLATE_PATH="$HOME/.${TEMPLATE_NAME}"

		if [ -f "$TEMPLATE_PATH" ]; then
			print-success "backing up ${TEMPLATE_NAME}"
			cp "$TEMPLATE_PATH" "$BACKUP_PATH/$TEMPLATE_NAME"
		fi

		cp "$TEMPLATE" "$TEMPLATE_PATH"
	done

	if [ -d "$AM_PROMPT" ]; then
		print-success "backing up $AM_PROMPT"
		cp -R "$AM_PROMPT"/* "$BACKUP_PATH" 1>/dev/null

		print-success "removing $AM_PROMPT"
		rm -rf "$AM_PROMPT/bash"    1>/dev/null 2>&1
		rm -rf "$AM_PROMPT/sh"      1>/dev/null 2>&1
		rm -rf "$AM_PROMPT/zsh"     1>/dev/null 2>&1
		rm -rf "$AM_PROMPT/themes"  1>/dev/null 2>&1

		# remove legacy paths
		rm -rf "$AM_PROMPT/completions" 1>/dev/null 2>&1
		rm -rf "$AM_PROMPT/scripts"     1>/dev/null 2>&1
		rm -f "$AM_PROMPT/bashrc"       1>/dev/null 2>&1
	fi

	print-success "creating $AM_PROMPT"
	mkdir -p "$AM_PROMPT/user" 1>/dev/null 2>&1

	print-success "installing promptMastermind to $AM_PROMPT"
	cp -Rf "$SCRIPT_DIR/src/bash"   "$AM_PROMPT" 1>/dev/null
	cp -Rf "$SCRIPT_DIR/src/sh"     "$AM_PROMPT" 1>/dev/null
	cp -Rf "$SCRIPT_DIR/src/zsh"    "$AM_PROMPT" 1>/dev/null
	cp -Rf "$SCRIPT_DIR/src/themes" "$AM_PROMPT" 1>/dev/null

	for USER_ITEM in "$SCRIPT_DIR"/src/user/*; do
		USER_ITEM_NAME=$(basename "$USER_ITEM")
		USER_ITEM_PATH="$AM_PROMPT/user/$USER_ITEM_NAME"

		if [ ! -f "$USER_ITEM_PATH" ]; then
			print-success "initializing user profile: $USER_ITEM_NAME at $USER_ITEM_PATH"
			cp "$USER_ITEM" "$USER_ITEM_PATH"
		fi
	done

	if [ -f /etc/os-release ]; then
		. /etc/os-release
		UNAMES="$ID ${ID_LIKE:-unknown} linux"
	else
		UNAMES=$(uname | tr '[:upper:]' '[:lower:]')
	fi

	UNAME=
	until [ "$UNAME" = "$UNAMES" ]; do
		UNAME=${UNAMES%%' '*}
		UNAMES=${UNAMES#*' '}

		UNAME_PATH="$AM_PROMPT/sh/install/$UNAME.sh"

		if [ ! -f "$UNAME_PATH" ]; then
			continue
		fi

		print-success "installing platform prerequisites ($UNAME)"
		. "$UNAME_PATH"

		break
	done

	if [ ! -d "$AM_PROMPT/zsh/completions" ]; then
		mkdir -p "$AM_PROMPT/zsh/completions" 1>/dev/null
	fi

	if [ ! -d "$AM_PROMPT/bash/completions" ]; then
		mkdir -p "$AM_PROMPT/bash/completions" 1>/dev/null
	fi

	PROMPT_SHA=$(cat "$SCRIPT_DIR/VERSION")
	PROMPT_SHA_PATH=$HOME/.am/prompt/.sha

	printf "%s\n" "$PROMPT_SHA" > "$PROMPT_SHA_PATH"

	# get the requested shell
	PROMPT_SHELL="${1:-$(printf "%s" "$SHELL" | rev | cut -d'/' -f1 | rev)}"

	# test if the current shell is something other than zsh
	if [ "$PROMPT_SHELL" != "zsh" ]; then

		# default to bash
		PROMPT_SHELL="bash"
	fi

	# lowercase the prompt shell
	PROMPT_SHELL=$(printf "%s" $PROMPT_SHELL | tr '[:upper:]' '[:lower:]')

	# use the correct shell
	. "$AM_PROMPT/sh/scripts/use-shell"

	# open the changelog url
	"$AM_PROMPT/sh/scripts/open-url" "https://github.com/automotivemastermind/prompt/blob/$PROMPT_SHA/CHANGELOG.md"
}

print-warn "prompt: establishing sudo (you may be prompted for credentials)..."
sudo printf "%s\n" ""
print-success "prompt: sudo enabled"

trap 'print-warn "prompt: terminating install..."; exit 1;' INT

__am_prompt_install "$@"
