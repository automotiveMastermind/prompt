function flush-dns() {
	dscacheutil -flushcache
	sudo killall -HUP mDNSResponder
}

function flushdns() {
	flush-dns
}