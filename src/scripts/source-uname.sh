function source-uname() {	
	for f in ~/.ssh/scripts/$(uname)/*; do
		source $f
	done
}

source-uname