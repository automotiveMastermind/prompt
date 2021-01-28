#! /usr/bin/env sh

__am_prompt_install_centos() {
	YUM=$(command -v dnf 2>/dev/null || command -v yum 2>/dev/null)
	PACKAGES='zsh'

	print-success "centos: installing $PACKAGES..."
	# shellcheck disable=SC2086
	sudo "$YUM" install -y $PACKAGES
}

__am_prompt_install_centos
