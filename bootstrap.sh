#! /usr/bin/env sh

set -e

if [ -t 1 ]; then
	FORMAT_CLEAR=$(tput sgr0)	# CLEAR ALL FORMAT
	FORMAT_BOLD=$(tput bold)	# SET BRIGHT/BOLD

	CLR_RED=$(tput setaf 1)		# ANSI RED
	CLR_GREEN=$(tput setaf 2)	# ANSI GREEN
	CLR_YELLOW=$(tput setaf 3)	# ANSI YELLOW

	CLR_SUCCESS="$FORMAT_BOLD$CLR_GREEN"
	CLR_WARN="$FORMAT_BOLD$CLR_YELLOW"
	CLR_FAIL="$FORMAT_BOLD$CLR_RED"
else
	FORMAT_CLEAR=''

	CLR_SUCCESS="\n--------------------------------------------------------------------------------\n"
	CLR_WARN="\n********************************************************************************\n"
	CLR_FAIL="\n################################################################################\n"
fi

__am_prompt_print_notice()
{
	printf "${1}%s${FORMAT_CLEAR}\n" "$@"
}

__am_prompt_print_success()
{
	printf "${CLR_SUCCESS}%s${FORMAT_CLEAR}\n" "$@"
}

__am_prompt_print_warn()
{
	printf "${CLR_WARN}%s${FORMAT_CLEAR}\n" "$@"
}

__am_prompt_print_fail()
{
	printf "${CLR_FAIL}%s${FORMAT_CLEAR}\n" "$@"
}

alias print-notice='__am_prompt_print_notice'
alias print-success='__am_prompt_print_success'
alias print-warn='__am_prompt_print_warn'
alias print-fail='__am_prompt_print_fail'

__am_prompt_update()
{
	GITHUB_TOKEN=${GITHUB_TOKEN:-}
	PROMPT_TOKEN=${PROMPT_TOKEN:-}
	PROMPT_TOKEN=${PROMPT_TOKEN:-$GITHUB_TOKEN}
	PROMPT_CURL_OPT=${PROMPT_CURL_OPT:-'-s'}
	PROMPT_COMMIT_REF=${PROMPT_COMMIT_REF:-"master"}
	PROMPT_SHELL=${PROMPT_SHELL:-"bash"}
	PROMPT_DRY_RUN=${PROMPT_DRY_RUN:-}

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

	if [ -n "${PROMPT_TOKEN:-}" ]; then
		PROMPT_CURL_OPT="$PROMPT_CURL_OPT -H 'Authorization: token $PROMPT_TOKEN'"
	fi

	PROMPT_SHA_URI="https://api.github.com/repos/automotiveMastermind/prompt/commits/$PROMPT_COMMIT_REF"
	PROMPT_SHA=$(curl "$PROMPT_CURL_OPT" "$PROMPT_SHA_URI" | grep sha | head -n 1 | sed 's#.*\:.*"\(.*\).*",#\1#')

	# detect if sha could be located
	if [ -z "${PROMPT_SHA:-}" ]; then
		print-fail "prompt: cannot retrieve SHA of latest version. Are you connected to the internet?"
		return 1
	fi

	PROMPT_SHA_PATH=$HOME/.am/prompt/.sha

	# detect if sha file exists
	if [ -f "$PROMPT_SHA_PATH" ]; then

		# get the value of the sha file
		PROMPT_CURRENT_SHA=$(cat "$PROMPT_SHA_PATH")

		# print latest version already installed
		if [ "${PROMPT_SHA}" = "${PROMPT_CURRENT_SHA}" ]; then
			print-warn \
				"prompt: latest version already installed: ${PROMPT_SHA}" \
				"  - run update-prompt with the --force flag to reinstall ${CLR_CLEAR}"
			return 0
		fi
	fi

	if [ -n "${PROMPT_DRY_RUN:-}" ]; then
		print-warn" \
			prompt: a new version of prompt is available: ${PROMPT_SHA}" \
			"  - run the update-prompt command line tool to upgrade${CLR_CLEAR}"
		return 0
	fi

	PROMPT_INSTALL_URI="https://github.com/automotiveMastermind/prompt/archive/$PROMPT_COMMIT_REF.tar.gz"
	PROMPT_INSTALL_TEMP=$(mktemp -d)

	curl -skLo "$PROMPT_INSTALL_TEMP/prompt.tgz" "$PROMPT_INSTALL_URI"
	tar -xzf "$PROMPT_INSTALL_TEMP/prompt.tgz" --strip-components=1 --directory="$PROMPT_INSTALL_TEMP"

	"$PROMPT_INSTALL_TEMP/install.sh" "$PROMPT_SHELL" "$PROMPT_INSTALL_TEMP"
}

trap 'print-warn "prompt: terminating update..."; exit 1;' INT

__am_prompt_update "$@"
