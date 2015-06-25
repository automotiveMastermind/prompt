function show-all() {
	defaults write com.apple.finder AppleShowAllFiles TRUE
	killall Finder
}
