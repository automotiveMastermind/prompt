function show-colors() {
	set | egrep 'CLR_w*'
}

function colors() {
	show-colors
}

function lc() {
	show-colors
}