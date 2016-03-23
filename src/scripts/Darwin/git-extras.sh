if [ -n "${UBER_DEBUG+1}" ]; then
    echo 'git-extras'
fi

if ! type dnvm >/dev/null 2>&1; then
    if type brew >/dev/null 2>&1; then
        brew install git-extras >/dev/null 2>&1;
    fi
fi

function git-lines() {
    git summary --line
}

function git-commits() {
    git summary
}

function lines() {
    git-lines
}

function commits() {
    git-commits
}