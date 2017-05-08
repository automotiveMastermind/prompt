#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'edit-vars'
fi

edit-vars() {
    local varpath="$AM_PROMPT/user/variables.sh"

    if [ ! -f $varpath ]; then
        echo "#!/usr/bin/env bash" > "$varpath"
        echo >> "$varpath"
    fi

    ${EDITOR:-vi} "$varpath"
}