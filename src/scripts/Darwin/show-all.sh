if [ -n "${UBER_DEBUG+1}" ]; then
    echo 'show-all'
fi
function show-all() {
	defaults write com.apple.finder AppleShowAllFiles TRUE
	killall Finder
}
