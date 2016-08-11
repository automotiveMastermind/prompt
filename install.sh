CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

now=$(date +"%Y%m%d_%H%M%S")

success "Creating backup path : $pwd/backup/$now..."
mkdir -p "backup/$now" 1>/dev/null

function success() {
    echo -e "${CLR_SUCCESS}$1${CLR_CLEAR}"
}

if test -d ~/.uber; then
    success "Backing up ~/.uber..."
    cp -R ~/.uber/* "backup/$now" 1>/dev/null
    
    success "Removing ~/.uber..."
    rm -rf ~/.uber 1>/dev/null
fi

success "Creating ~/.uber..."
mkdir -p ~/.uber 1>/dev/null

success "Installing uber to ~/.uber..."
cp -Rf src/* ~/.uber 1>/dev/null

if test -f backup/uber/scripts/bookmarks.sh; then
    success "Restoring bookmarks..."
    cp -R backup/uber/scripts/bookmarks.sh ~/.uber/scripts 1>/dev/null
fi

if test -f ~/.bash_profile; then
    success "Backing up bash profile..."
    cp ~/.bash_profile backup/bash_profile

    if ! $(grep -q "~/.uber/bashrc" ~/.bash_profile); then
        success "Sourcing uber in bash profile..."
        cat template >> ~/.bash_profile
    fi
else
    success "Sourcing uber in bash profile..."
    cat template > ~/.bash_profile
fi

LOCAL_PREFIX=/usr/local

if test "$(uname)" = "Darwin"; then
    if ! type brew 2>/dev/null; then
        success "Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    
    LOCAL_PREFIX=$(brew --prefix)

    success "Updating Homebrew..."
    brew update 1>/dev/null
    
    for pkg in git-flow; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            success "Uninstalling $pkg..."
            brew uninstall ${pkg}
        fi
    done
    
    rm -rf "$LOCAL_PREFIX/etc/bash_completion.d/git-prompt.sh" 1>/dev/null
    
    for pkg in git git-extras git-flow-avh gnu-getopt mono homebrew/versions/node5 openssl; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            success "Upgrading $pkg..."
            brew upgrade ${pkg} 1>/dev/null
        else
            success "Installing $pkg..."
            brew install ${pkg}
        fi
    done
    
    git config --system credential.helper osxkeychain
    
    success "Tapping extended versions for caskroom..."
    brew tap caskroom/versions 1>/dev/null
    
elif test "$(uname)" = "MINGW64_NT-10.0"; then
    LOCAL_PREFIX=$LOCALAPPDATA/git
    
    mkdir -p "$LOCAL_PREFIX" 1>/dev/null
fi

gitpromptname=git-prompt.sh
gitcompletename=git-flow-completion.bash
gitprompt=$LOCAL_PREFIX/etc/bash_completion.d
gitprompturi=https://raw.githubusercontent.com/lyze/posh-git-sh/master/$gitpromptname
gitcompleteuri=https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/$gitcompletename

if test -f "$gitprompt/$gitcompletename"; then
    success "Removing git flow bash completion..."
    rm -rf "$gitprompt/$gitcompletename" 1>/dev/null
fi

if test -f "$gitprompt/$gitpromptname"; then
    success "Removing crappy git-prompt..."
    rm -rf "$gitprompt/$gitpromptname" 1>/dev/null
else
    mkdir -p "$gitprompt" 1>/dev/null
fi

success "Downloading better git-prompt..."
result=$(curl -s -L -D - "$gitprompturi" -o "$gitpromptname" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

if test "$result" = "200"; then
    success "Installing successfully downloaded git-prompt..."
    cp $gitpromptname "$gitprompt" 1>/dev/null
    rm -rf $gitpromptname 1>/dev/null
fi

success "Downloading git-flow completion..."
result=$(curl -s -L -D - "$gitcompleteuri" -o "$gitcompletename" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

if test "$result" = "200"; then
    success "Installing successfully downloaded git-flow completion..."
    cp $gitcompletename "$gitprompt" 1>/dev/null
    rm -rf $gitcompletename 1>/dev/null
fi

echo -e "${CLR_SUCCESS}"
echo "#######################################"
echo "#######################################"
echo "   PLEASE OPEN A NEW TERMINAL WINDOW"
echo "#######################################"
echo "#######################################"
echo -e "${CLR_CLEAR}"