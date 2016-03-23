if [ -n "${UBER_DEBUG+1}" ]; then
        echo 'remove-bookmark'
fi

remove-bookmark() {
    local b=$1
    local r=

    # check to see if a bookmark was specified, otherwise use current directory to remove the bookmark
    # using expanded if statement since the compact form seems to declare local variables of its own, even if the variable is declared
    # in a wider scope (local to the main function or even global)
    if [ ! -z $b ]; then
        r=$(command grep -s -m 1 ^$b ~/.ssh/scripts/bookmarks.sh)
    elif [ -z $2 ]; then
        r=$(command grep -s -m 1 \"$PWD\"$ ~/.ssh/scripts/bookmarks.sh)
    fi

    # using (! -z) instead of (-n) due to a bug (or a lack of understanding)  where (-n) tests when a variable contains nothing
    # after firing off the above command. Not sure how BASH handles null characters, if that is indeed what is being stored in $r.
    if [ ! -z $r ]; then
        [ -z $2 ] && ( echo Removing bookmark: $r )

        command grep -s -v $r ~/.ssh/scripts/bookmarks.sh >> ~/.ssh/scripts/bookmarks1.sh
        mv -f ~/.ssh/scripts/bookmarks1.sh ~/.ssh/scripts/bookmarks.sh

        source ~/.ssh/scripts/bookmarks.sh
    else
        [ -z $2 ] && ( echo No bookmark was declared for the specified title or address. )
    fi
}

function rbm() {
    remove-bookmark $@
}

function rb() {
    remove-bookmark $@
}