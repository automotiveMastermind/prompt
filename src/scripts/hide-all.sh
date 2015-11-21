function hide-all() {
	if [ "$(uname)" != "Darwin" ]; then
		return
	fi
	
	defaults write com.apple.finder AppleShowAllFiles FALSE
	killall Finder
}