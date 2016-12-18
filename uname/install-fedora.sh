CLR_SUCCESS="\033[1;32m"    # BRIGHT GREEN
CLR_CLEAR="\033[0m"         # DEFAULT COLOR

function success() {
    echo -e "${CLR_SUCCESS}$1${CLR_CLEAR}"
}

for pkg in openssl git libunwind libicu; do
    success "Installing $pkg..."
    sudo dnf install ${pkg}
done

curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
nvm install --lts 1>/dev/null
nvm use --lts 1>/dev/null

wget --no-check-certificate -q  https://raw.github.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh && sudo bash gitflow-installer.sh install stable; rm gitflow-installer.sh