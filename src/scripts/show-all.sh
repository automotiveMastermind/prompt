function show-all() {
	if [ "$(uname)" != "Darwin" ]; then
		return
	fi
	
	defaults write com.apple.finder AppleShowAllFiles TRUE
	killall Finder
}
