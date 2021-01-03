#! /usr/bin/env sh

set -e

__am_prompt_install_linux() {

	BREWS='gcc git gpg starship gh nvm'

	if ! command -v brew 1>/dev/null 2>&1; then
		print-success "installing homebrew..."
		bash -c "CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) || true"

		. "$AM_PROMPT/sh/scripts/eval/set-brew-path"

		# disable brew analytics
		brew analytics off
	fi

	print-success "updating homebrew..."
	brew update

	for pkg in $BREWS; do
		if brew list --versions "$pkg" 1>/dev/null; then
			print-success "linux: upgrading $pkg..."
			brew upgrade "$pkg" 2>/dev/null || true
			brew link --overwrite "$pkg" 2>/dev/null || true
		else
			print-success "linux: installing $pkg..."
			brew install "$pkg" || true
		fi
	done

	# make sure we have ownership of linuxbrew
	sudo chown -R "$(whoami)" /home/linuxbrew/.linuxbrew

	GPG_CONFIG_DIR="$(gpgconf --list-dirs homedir)"

	# test for gpg config
	if [ ! -d "$GPG_CONFIG_DIR" ]; then

		# create the gpg config directory
		mkdir -p "$GPG_CONFIG_DIR"

		# set the permissions
		chmod u=rwx,go= "$GPG_CONFIG_DIR"

		# apply initial defaults
		gpgconf --apply-defaults 2>/dev/null || true
	fi

	print-success "upgrading: fira code font..."
	FONT_DIR="$HOME/.local/share/fonts/NerdFonts"
	TEMP_DIR=$(mktemp -d)

	# download fonts
	curl -sLo "$TEMP_DIR/FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

	# determine if fira code already exists
	if [ -d "$FONT_DIR" ]; then

		# delete fira code
		rm -rf "$FONT_DIR" 1>/dev/null 2>&1
	fi

	# make sure the font dir exists
	mkdir -p "$FONT_DIR" 1>/dev/null

	# extract fira code
	unzip "$TEMP_DIR/FiraCode.zip" 'Fira*.otf' -x '*Windows*' -d "$FONT_DIR" 1>/dev/null

	# remove temp
	rm -rf "$TEMP_DIR" 1>/dev/null 2>&1
}

__am_prompt_install_linux
