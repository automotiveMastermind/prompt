if test -n "${UBER_DEBUG+1}"; then
        echo 'dotnet'
fi

function install-dotnet() {
    local dotnetpath=$HOME/.dotnet
    local dotneturi="https://raw.githubusercontent.com/dotnet/cli/rel/1.0.0/scripts/obtain/dotnet-install.sh"
    local dotnetsh=$dotnetpath/dotnet-install.sh
    
    # determine if dotnet is already on the path
    if test dotnet; then
        return
    fi
    
    # determine if the dotnet folder exists
    if test ! -d "$dotnetpath"; then
        # create the dotnet folder
        mkdir -p "$dotnetpath"
    fi

    # determine if the dotnet script file does not exist
    if test ! -f "$dotnetsh"; then
        # attempt to download it from curl
        local result=$(curl -L -D - "$dotneturi" -o "$dotnetsh" -# | grep "^HTTP/1.1" | head -n 1 | sed "s/HTTP.1.1 \([0-9]*\).*/\1/")

        # source it if it was successfully retrieved
        test "$result" = "200" && chmod ugo+x "$dotnetsh"
    fi

    # determine if dotnet now exists in the expected place
    if test -f "$dotnetsh"; then
        # add the dotnet folder to path
        PATH=$PATH:$dotnetpath

        # source dotnet
        source $dotnetsh
    fi
}