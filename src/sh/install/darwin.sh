#! /usr/bin/env bash

set -e

__am_prompt_ensure_rosetta() {

	# determine if we are on x86
	if [ "$(uname -m)" = "x86_64" ]; then

		# install homebrew using defaults
		__am_prompt_install_intel

		# move on immediately
		return $?
	fi

	printf "%s" "$CLR_WARN"
	cat <<-EOT
		##############################################################################

		DETECTED APPLE SILICON

		Apple Silicon is NOW officially supported by homebrew but some formulae do
		not yet have bottles available. As such, we will continue to install both
		apple silicon and intel homebrew in the following locations:

		- /opt/homebrew : arm64e native (DEFAULT)
		- /usr/   : x86_64 emulation via Rosetta 2

		The Apple Silicon (arm64e) version will be the default as it will be placed
		on the PATH variable before the native version. While this is not compatible
		with most formulae, we expect this to improve over time. To use the
		intel (x86_64) version, you can use the \`brew-intel\` alias. For example:

		brew-intel install git

		##############################################################################
	EOT
	printf "%s\n" "$FORMAT_CLEAR"

	 # install homebrew for apple silicon
	__am_prompt_install_arm64

	# install homebrew in rosetta
	__am_prompt_install_rosetta
}

__am_prompt_install_intel() {
	printf "\n${CLR_SUCCESS}%s\n%s\n%s${FORMAT_CLEAR}\n\n" \
		"##############################################################################" \
		"INSTALLING VIA HOMEBREW FOR INTEL MACS" \
		"##############################################################################"

	HOMEBREW_PREFIX="/usr/local"
	BREW_CMD="$HOMEBREW_PREFIX/bin/brew"

	if ! command -v $BREW_CMD 1>/dev/null 2>&1; then
		print-success "installing homebrew..."
		/bin/bash -c "CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && $BREW_CMD config"
	fi

	__am_prompt_install_darwin "/usr/local/bin/brew"
}

__am_prompt_install_rosetta() {
	printf "\n${CLR_SUCCESS}%s\n%s\n%s${FORMAT_CLEAR}\n\n" \
		"##############################################################################" \
		"INSTALLING VIA HOMEBREW FOR ROSETTA 2 (x86_64)"
		"##############################################################################"

	# install rosetta 2
	softwareupdate --install-rosetta --agree-to-license 2>/dev/null

	HOMEBREW_PREFIX="/usr/local"
	BREW_CMD="$HOMEBREW_PREFIX/bin/brew"

	if ! command -v $BREW_CMD 1>/dev/null 2>&1; then
		print-success "installing homebrew..."
		arch -x86_64 /bin/bash -c "HOMEBREW_PREFIX=/usr/CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && $BREW_CMD config"
	fi

	__am_prompt_install_darwin "arch -x86_64 /usr/local/bin/brew"
}

__am_prompt_install_arm64() {
	printf "\n${CLR_SUCCESS}%s\n%s\n%s${FORMAT_CLEAR}\n\n" \
		"##############################################################################" \
		"INSTALLING VIA HOMEBREW FOR APPLE SILICON (arm64e)"
		"##############################################################################"

	HOMEBREW_PREFIX="/opt/homebrew"
	BREW_CMD="$HOMEBREW_PREFIX/bin/brew"

	if ! command -v $BREW_CMD 1>/dev/null 2>&1; then
		print-success "installing homebrew..."
		/bin/bash -c "HOMEBREW_PREFIX=$HOMEBREW_PREFIX CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && $BREW_CMD config"
	fi

	__am_prompt_install_darwin "arch -arm64e /opt/homebrew/bin/brew"
}

__am_prompt_install_darwin() {
	BREWS='openssl git go nvm python gpg pinentry-mac starship gh'
	BREW_CMD=${1:-"/usr/local/bin/brew"}

	# disable brew analytics
	$BREW_CMD analytics off

	print-success "updating homebrew..."
	$BREW_CMD update

	for pkg in $BREWS; do
		if $BREW_CMD list --versions "$pkg" 1>/dev/null; then
			print-success "macos: upgrading $pkg..."
			$BREW_CMD upgrade "$pkg" 2>/dev/null || true
			$BREW_CMD link --overwrite "$pkg" 2>/dev/null || true
		else
			print-success "macos: installing $pkg..."
			$BREW_CMD install "$pkg" || true
		fi
	done

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

	print-success "setting git credential helper to use the macOS keychain..."
	git config --system credential.helper osxkeychain
}

__am_prompt_install_fonts() {

	# install font
	print-success "installing: fira code nerd font..."

	# setup the font dir
	FONT_DIR="$HOME/Library/Fonts/NerdFonts"

	# create a temp dir for fonts
	TEMP_DIR=$(mktemp -d)

	# download fonts
	curl -sLo "$TEMP_DIR/FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

	# determine if fira code already exists
	if [ -d "$FONT_DIR" ]; then

		# delete fira code
		rm -rf "$FONT_DIR" 1>/dev/null 2>&1
	fi

	# ensure the fira code directory
	mkdir -p "$FONT_DIR" 1>/dev/null 2>&1

	# extract fira code
	unzip "$TEMP_DIR/FiraCode.zip" 'Fira*.otf' -x '*Windows*' -d "$FONT_DIR" 1>/dev/null

	# remove temp
	rm -rf "$TEMP_DIR" 1>/dev/null 2>&1
}

__am_prompt_ensure_rosetta
__am_prompt_install_fonts
