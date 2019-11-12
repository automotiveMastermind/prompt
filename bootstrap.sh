#!/usr/bin/env sh

set -e

function __am_prompt_update()
{
    local CLR_FAIL=${CLR_FAIL:-"\033[1;31m"}        # BRIGHT RED
    local CLR_SUCCESS=${CLR_SUCCESS:-"\033[1;32m"}  # BRIGHT GREEN
    local CLR_WARN=${CLR_WARN:-"\033[1;33m"}        # BRIGHT YELLOW
    local CLR_CLEAR=${CLR_CLEAR:-"\033[0m"}         # DEFAULT COLOR

    local GH_TOKEN=${GH_TOKEN:-}
    local PROMPT_TOKEN=${PROMPT_TOKEN:-}
    local PROMPT_TOKEN=${PROMPT_TOKEN:-$GH_TOKEN}
    local PROMPT_CURL_OPT=${PROMPT_CURL_OPT:-'-s'}
    local PROMPT_COMMIT_REF=${PROMPT_COMMIT_REF:-"master"}
    local PROMPT_SHELL=${PROMPT_SHELL:-"bash"}
    local PROMPT_DRY_RUN=${PROMPT_DRY_RUN:-}

    while :; do
        case $1 in
            -t|--token)
                PROMPT_TOKEN=$2
                shift
                ;;
            -v|--version)
                PROMPT_COMMIT_REF=$2
                shift
                ;;
            -dr|--dry-run)
                PROMPT_DRY_RUN=1
                ;;
            -f|--force)
                rm -rf "$HOME/.am/prompt/.sha" 1>/dev/null 2>&1
                ;;
            --debug)
                set -x
                ;;
            ?*)
                PROMPT_SHELL=$1
                ;;
            *)
                break
                ;;
        esac
        shift
    done

    if [ ! -z "${PROMPT_TOKEN:-}" ]; then
        PROMPT_CURL_OPT='$PROMPT_CURL_OPT -H "Authorization: token $PROMPT_TOKEN"'
    fi

    local PROMPT_SHA_URI="https://api.github.com/repos/automotiveMastermind/prompt/commits/$PROMPT_COMMIT_REF"
    local PROMPT_SHA=$(curl $PROMPT_CURL_OPT $PROMPT_SHA_URI | grep sha | head -n 1 | sed 's#.*\:.*"\(.*\).*",#\1#')

    # detect if sha could be located
    if [ -z ${PROMPT_SHA:-} ]; then
        echo "${CLR_FAIL}prompt: cannot retrieve SHA of latest version. Are you connected to the internet?${CLR_CLEAR}"
        return 1
    fi

    local PROMPT_SHA_PATH=$HOME/.am/prompt/.sha

    # detect if sha file exists
    if [ -f "$PROMPT_SHA_PATH" ]; then

        # get the value of the sha file
        PROMPT_CURRENT_SHA=$(cat "$PROMPT_SHA_PATH")

        # print latest version already installed
        if [ "${PROMPT_SHA}" = "${PROMPT_CURRENT_SHA}" ]; then
            echo "${CLR_SUCCESS}prompt: latest version already installed: ${PROMPT_SHA}.${CLR_CLEAR}"
            echo "  - run update-prompt with the --force flag to reinstall ${CLR_CLEAR}"
            exit 0
        fi
    fi

    if [ ! -z "${PROMPT_DRY_RUN:-}" ]; then
        echo "${CLR_WARN}prompt: a new version of prompt is available: ${PROMPT_SHA}."
        echo "  - run the update-prompt command line tool to upgrade${CLR_CLEAR}"
        return 0
    fi

    remove-backup

    local PROMPT_CHANGELOG_URI="https://github.com/automotivemastermind/prompt/blob/$PROMPT_COMMIT_REF/CHANGELOG.md"
    local PROMPT_INSTALL_URI="https://github.com/automotiveMastermind/prompt/archive/$PROMPT_COMMIT_REF.tar.gz"
    local PROMPT_INTALL_TEMP=$(mktemp -d)
    local PROMPT_EXTRACT_TEMP="$PROMPT_INTALL_TEMP/extract"

    pushd $PROMPT_INTALL_TEMP 1>/dev/null
    curl -skL $PROMPT_INSTALL_URI | tar zx
    pushd prompt-master 1>/dev/null
    ./install.sh $PROMPT_SHELL
    popd 1>/dev/null
    popd 1>/dev/null

    rm -rf $PROMPT_INTALL_TEMP 1>/dev/null

    open-url $CHANGELOG_URI 1>/dev/null
}

__am_prompt_update $@
