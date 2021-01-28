#! /usr/bin/env sh

set -e

__am_prompt_install_fedora() {
	PACKAGES='libxcrypt-compat'

	print-success "fedora: installing $PACKAGES..."
	# shellcheck disable=SC2086
	sudo dnf install -y $PACKAGES
}

__am_prompt_install_fedora
