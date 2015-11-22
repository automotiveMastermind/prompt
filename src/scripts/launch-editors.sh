function launch-code() {
    if [ "$(uname)" != "Darwin" ]; then
        return
    fi
    
    VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*
}

function launch-sublime() {
    if [ "$(uname)" != "Darwin" ]; then
        return
    fi

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