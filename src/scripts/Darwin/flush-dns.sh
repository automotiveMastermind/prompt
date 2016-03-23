if [ -n "${UBER_DEBUG+1}" ]; then
    echo 'flush-dns'
fi

function flush-dns() {
	dscacheutil -flushcache
	sudo killall -HUP mDNSResponder
}

function flushdns() {
	flush-dns
}