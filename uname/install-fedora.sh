CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

success() {
    echo -e "${CLR_SUCCESS}$1${CLR_CLEAR}"
}

for pkg in openssl git libunwind libicu; do
    success "Installing $pkg..."
    sudo dnf install ${pkg}
done

curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

nvm install --lts 1>/dev/null
nvm use --lts --delete-prefix 1>/dev/null
