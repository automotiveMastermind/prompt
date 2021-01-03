#! /usr/bin/env sh

__am_prompt_install_darwin() {
	BREWS='zsh'

	for pkg in $BREWS; do
		if brew list --versions "$pkg" 1>/dev/null; then
			print-success "macos: upgrading $pkg..."
			brew upgrade $pkg 2>/dev/null || true
			brew link --overwrite $pkg 2>/dev/null || true
		else
			print-success "macos: installing $pkg..."
			brew install $pkg || true
		fi
	done

	# set permissions on the site-functions paths
	sudo chmod u=rwx,go=rx "$LOCAL_PREFIX/share/zsh"
	sudo chown "$(whoami)" "$LOCAL_PREFIX/share/zsh"

	sudo chmod u=rwx,go=rx "$LOCAL_PREFIX/share/zsh/site-functions"
	sudo chown "$(whoami)" "$LOCAL_PREFIX/share/zsh/site-functions"

	# test to see if the zsh completion dir is specified
	if [ -n "${ZSH_COMPLETION_DIR:-}" ]; then

		# set permissions on the script directory
		sudo chmod u=rwx,go=rx "$ZSH_COMPLETION_DIR"
		sudo chown "$(whoami)" "$ZSH_COMPLETION_DIR"
	fi

	# remove any cached zsh completion
	rm -f "$HOME"/.zcompdump* 1>/dev/null 2>&1 || true
}

__am_prompt_install_darwin
