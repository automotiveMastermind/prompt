function launch-code() {
    if [[ $# = 0 ]]; then
        echo "Open Visual Studio Code"
        open -n -a "Visual Studio Code"
    else [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        echo "Opening Visual Studio Code at: $F"
	open -n -a "Visual Studio Code" --args "$F"
    fi
}

function launch-sublime() {
    if [[ $# = 0 ]]; then
        echo "Opening Sublime Text"
        open -n -a "Sublime Text"
    else [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        echo "Opening Sublime Text at: $F"
        open -n -a "Sublime Text" --args "$F"
    fi
}

function code() {
	launch-code $@
}

function sublime() {
	launch-sublime $@
}
