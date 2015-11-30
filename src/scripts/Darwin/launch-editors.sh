function launch-code() {
    if test -d /Applications/Visual\ Studio\ Code.app; then
        VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*
    else
        echo "Visual Studio Code is not installed... please install it from http://code.visualstudio.com"
    fi
}

function launch-sublime() {
    if test -f /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl; then
        /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $*
    else
        echo "SublimeText is not installed... please install it from http://sublimetext.com"
    fi
}

function launch-atom() {
    if test -f /Applications/Atom.app/Contents/Resources/app/atom.sh; then
        /Applications/Atom.app/Contents/Resources/app/atom.sh $*
    else
        echo "Atom is not installed... please install it from http://atom.io"
    fi
}

function atom() {
    launch-atom $@
}

function code() {
    launch-code $@
}

function sublime() {
    launch-sublime $@
}

function subl() {
    launch-sublime $@
}