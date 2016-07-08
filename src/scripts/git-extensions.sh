if test -n "${UBER_DEBUG+1}"; then
        echo 'git-extensions'
fi

git-clone() {
	if ! test -f $(which git); then
		echo "Git is not available on the current path. Exiting."
		return
	fi

	local url=$1
	local name=$2

	if test -z "$url"; then
		echo "You must specify a url, which is the first parameter."
		return
	fi

	if test -z "$name"; then
		echo "You must specify a directory name, which is the second parameter."
		return
	fi

	git clone $url $name && \
	cd $name && \
	git branch -a | sed -n "/\/HEAD /d; /\/master$/d; /\/develop$/d; /remotes/p;" | xargs -L1 git checkout -t 2>/dev/null

	echo Checking out master and develop branches...

	git checkout develop 2>/dev/null
	git checkout -b master 2>/dev/null
	git checkout master 2>/dev/null

	git flow init -d 2>/dev/null
}

clone() {
	git-clone $@
}