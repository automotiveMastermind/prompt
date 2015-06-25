function play-login() {
	if [[ -f ~/.ssh/sounds/login.mp3 ]]; then
		afplay ~/.ssh/sounds/login.mp3
	fi
}

function logi() {
	play-login
}