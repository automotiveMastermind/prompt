function flush-dns() {
	if [ "$(uname)" != "Darwin" ]; then
		return
	fi
	
	dscacheutil -flushcache
	sudo killall -HUP mDNSResponder
}

function flushdns() {
	flush-dns
}