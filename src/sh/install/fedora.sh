#! /usr/bin/env sh

set -e

__am_prompt_install_fedora() {
	PACKAGES='libxcrypt-compat'

	print-success "installing $PACKAGES..."
	# shellcheck disable=SC2086
	sudo dnf install -y $PACKAGES

	. "$AM_PROMPT"/sh/install/centos.sh
}

__am_prompt_install_fedora
