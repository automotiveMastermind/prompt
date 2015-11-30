function hide-all() {
	defaults write com.apple.finder AppleShowAllFiles FALSE
	killall Finder
}