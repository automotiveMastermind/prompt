if [ -n "${UBER_DEBUG+1}" ]; then
    echo 'hide-all'
fi
function hide-all() {
	defaults write com.apple.finder AppleShowAllFiles FALSE
	killall Finder
}