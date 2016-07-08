echo "Removing old backup..."
rm -rf backup 1>/dev/null 2>&1

if test -d ~/.ssh; then
    echo "Creating backup path..."
    mkdir -p backup/ssh 1>/dev/null 2>&1

    echo "Backing up ~/.ssh..."
    cp -R ~/.ssh/* backup/ssh 1>/dev/null 2>&1
    
    echo "Removing ~/.ssh..."
    rm -rf ~/.ssh 1>/dev/null 2>&1
fi

echo "Creating ~/.ssh..."
mkdir -p ~/.ssh 1>/dev/null 2>&1

echo "Installing uber to ~/.ssh..."
cp -Rf src/* ~/.ssh 1>/dev/null 2>&1

if test -f backup/ssh/scripts/bookmarks.sh; then
    echo "Restoring bookmarks..."
    cp -R backup/ssh/scripts/bookmarks.sh ~/.ssh/scripts 1>/dev/null 2>&1
fi

if test -f ~/.bash_profile; then
    echo "Backing up bash profile..."
    cp ~/.bash_profile backup/bash_profile

    if ! $(grep -q "~/.ssh/bashrc" ~/.bash_profile); then
        echo "Sourcing uber in bash profile..."
        cat template >> ~/.bash_profile
    fi
else
    echo "Sourcing uber in bash profile..."
    cat template > ~/.bash_profile
fi

LOCAL_PREFIX=/usr/local

if test "$(uname)" = "Darwin"; then
    if ! type brew 2>/dev/null; then
        echo "Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    
    LOCAL_PREFIX=$(brew --prefix)

    echo "Updating Homebrew..."
    brew update 1>/dev/null 2>&1
    
    for pkg in git-flow; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            echo "Uninstalling $pkg..."
            brew uninstall ${pkg}
        fi
    done
    
    rm -rf "$LOCAL_PREFIX/etc/bash_completion.d/git-prompt.sh" 1>/dev/null 2>&1
    
    for pkg in git git-extras git-flow-avh gnu-getopt mono homebrew/versions/node5 openssl; do
        if brew list -1 | grep -q "^${pkg}\$"; then
            echo "Upgrading $pkg..."
            brew upgrade ${pkg} 1>/dev/null 2>&1
        else
            echo "Installing $pkg..."
            brew install ${pkg}
        fi
    done
    
    git config --system credential.helper osxkeychain
    
    echo "Tapping extended versions for caskroom..."
    brew tap caskroom/versions 1>/dev/null 2>&1
    
elif test "$(uname)" = "MINGW64_NT-10.0"; then
    LOCAL_PREFIX=$LOCALAPPDATA/git
    
    mkdir -p "$LOCAL_PREFIX" 1>/dev/null 2>&1
fi

gitpromptname=git-prompt.sh
gitcompletename=git-flow-completion.bash
gitprompt=$LOCAL_PREFIX/etc/bash_completion.d
gitprompturi=https://raw.githubusercontent.com/lyze/posh-git-sh/3526027049ea07f6c21ab020d1cf6c0cea9895e0/$gitpromptname
gitcompleteuri=https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/$gitcompletename

if test -f "$gitprompt/$gitcompletename"; then
    echo "Removing git flow bash completion..."
    rm -rf "$gitprompt/$gitcompletename" 1>/dev/null 2>&1
fi

if test -f "$gitprompt/$gitpromptname"; then
    echo "Removing crappy git-prompt..."
    rm -rf "$gitprompt/$gitpromptname" 1>/dev/null 2>&1
else
    mkdir -p "$gitprompt" 1>/dev/null 2>&1
fi

echo "Downloading better git-prompt..."
result=$(curl -L -D - "$gitprompturi" -o "$gitpromptname" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")
test "$result" = "200" && cp $gitpromptname "$gitprompt" && rm -rf $gitpromptname

echo "Downloading git-flow completion..."
result=$(curl -L -D - "$gitcompleteuri" -o "$gitcompletename" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")
test "$result" = "200" && cp $gitcompletename "$gitprompt" && rm -rf $gitcompletename

echo
echo '######################################'
echo '######################################'
echo 'PLEASE OPEN A NEW TERMINAL WINDOW...'
echo '######################################'
echo '######################################'