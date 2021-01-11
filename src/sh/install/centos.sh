#! /usr/bin/env sh

__am_prompt_install_centos() {
	YUM=$(command -v dnf 2>/dev/null || command -v yum 2>/dev/null)
	PACKAGES='sudo curl file git which findutils bash util-linux-user'

	print-success "centos: installing development tools..."
	sudo "$YUM" groupinstall -y "Development Tools"

	print-success "installing $PACKAGES..."

	# shellcheck disable=SC2086
	sudo "$YUM" install -y $PACKAGES

	. "$AM_PROMPT/sh/install/linux.sh"
}

__am_prompt_install_centos
