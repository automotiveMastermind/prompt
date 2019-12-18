#! /usr/bin/env sh

set -eu

# set the git author and email
GIT_AUTHOR_EMAIL=${GIT_AUTHOR_EMAIL:-"open@automotivemastermind.com"}
GIT_COMMITTER_EMAIL=${GIT_COMMITTER_EMAIL:-$GIT_AUTHOR_EMAIL}
GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME:="aM Open Source"}
GIT_COMMITTER_NAME=${GIT_COMMITTER_NAME:-$GIT_AUTHOR_NAME}

# install yarn assets
yarn install --frozen-lockfile

# detect fossa api key
if [ ! -z "${FOSSA_API_KEY:-}" ]; then

    # determine if fossa is available
    if ! test type fossa 1>/dev/null 2>&1; then

        # get fossa
        curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/fossas/fossa-cli/master/install.sh | bash
    fi

    # run fossa analyze
    fossa analyze

    # wait for fossa report
    fossa test

    # generate license file
    fossa report licenses > NOTICE.md

    # add the notice to the current commit
    git add --force NOTICE.md
fi

# create the release
yarn run release

# determine if we are running in ci
if ! test -z "${CI:-}"; then
    GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME \
    GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL \
    EMAIL=$GIT_AUTHOR_EMAIL \
    GIT_COMMITTER_NAME=$GIT_COMMITTER_EMAIL \
    GIT_COMMITTER_EMAIL=$GIT_COMMITTER_EMAIL \
    git push --follow-tags origin master
fi
