#!/usr/bin/env bash
curl_opt='-s'
if [ ! -z "${GH_TOKEN:-}" ]; then
    curl_opt='$curl_opt -H "Authorization: token $GH_TOKEN"'
fi

sha_uri="https://api.github.com/repos/pulsebridge/prompt/commits/master"
sha=$(curl $curl_opt $sha_uri | grep sha | head -n 1 | sed 's#.*\:.*"\(.*\).*",#\1#')
sha_path=$HOME/.pulsebridge/prompt/$sha

if [ -f $sha_path ]; then
    echo "prompt: latest version already installed: $sha"
    exit 0
fi

uri="https://github.com/pulsebridge/prompt/archive/master.tar.gz"
temp=$(mktemp -d -t pb_prompt)
extract="$temp/extract"

pushd $temp 1>/dev/null
curl -skL $uri | tar zx
pushd prompt-master 1>/dev/null
./install.sh
popd 1>/dev/null

rm -rf $temp 1>/dev/null