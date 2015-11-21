function install-dnvm() {
    local dnvmpath=~/.dnx/dnvm
    local dnvmuri="https://raw.githubusercontent.com/aspnet/Home/dev/dnvm.sh"
    local dnvmsh=$dnvmpath/dnvm.sh

    # determine if the dnvm folder exists
    if test ! -d "$dnvmpath"; then
        # create the dnvm folder
        mkdir -p "$dnvmpath"
    fi

    # determine if the dnvm script file does not exist
    if test ! -f "$dnvmsh"; then
        # attempt to download it from curl
        local result=$(curl -L -D - "$dnvmuri" -o "$dnvmsh" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")
       
        # source it if it was successfully retrieved
        [[ $result == "200" ]] && chmod ugo+x "$dnvmsh"
    fi
}

function update-dnvm() {    
    (dnvm update-self &) 1>/dev/null 2>&1
}

# determine if dnvm is avialable
if ! type dnvm >/dev/null 2>&1; then
    # install dnvm
    install-dnvm 1>/dev/null 2>&1

    # determine if dnvm now exists in the expected place
    if test -f ~/.dnx/dnvm/dnvm.sh; then
        # add the dnvm folder to path
        PATH=$PATH:~/.dnx/dnvm

        # source dnvm
        source ~/.dnx/dnvm/dnvm.sh
    fi
fi

update-dnvm