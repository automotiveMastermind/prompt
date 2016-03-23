if [ -n "${UBER_DEBUG+1}" ]; then
    echo 'launch-editors'
fi
function launch-code() {
    if test -d /Applications/Visual\ Studio\ Code.app; then
        VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*
    else
        echo "Visual Studio Code is not installed... please install it from http://code.visualstudio.com"
    fi
}

function code() {
    launch-code $@
}