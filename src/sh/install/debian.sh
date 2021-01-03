#! /usr/bin/env sh

set -e

__am_prompt_install_debian() {
	SUDO=$(command -v sudo 2>/dev/null || "")
	PACKAGES="sudo build-essential curl file git bash procps"

	print-success "debian: updating software repositories..."
	$SUDO apt-get update

	print-success "debian: installing $PACKAGES..."
	# shellcheck disable=SC2086
	$SUDO apt-get install -y $PACKAGES

	print-success "debian: removing unnecessary dependencies..."
	$SUDO apt-get autoremove -y

	. "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_debian
