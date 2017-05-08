#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'edit-bashrc'
fi

edit-bashrc() {
    local bashrcpath="$AM_PROMPT/user/bashrc"

    if [ ! -f $bashrcpath ]; then
        echo "#!/usr/bin/env bash" > $bashrcpath
        echo >> $bashrcpath
    fi

    ${EDITOR:-vi} $bashrcpath
}