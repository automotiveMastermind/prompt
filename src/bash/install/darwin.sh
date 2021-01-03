#! /usr/bin/env sh

__am_prompt_install_darwin() {
	BREWS='bash bash-completion'

	for pkg in $BREWS; do
		if brew list --versions "$pkg" 1>/dev/null; then
			print-success "macOS: upgrading $pkg..."
			brew upgrade "$pkg" 2>/dev/null || true
			brew link --overwrite "$pkg" 2>/dev/null || true
		else
			print-success "macOS: installing $pkg..."
			brew install "$pkg" || true
		fi
	done
}

__am_prompt_install_darwin
