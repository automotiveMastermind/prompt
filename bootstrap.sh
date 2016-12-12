#!/usr/bin/env bash

uri="https://github.com/pulsebridge/prompt/archive/master.tar.gz"
temp=$(mktemp -d -t pb_prompt)
extract="$temp/extract"

pushd $temp 1>/dev/null
curl -skL $uri | tar zx
pushd prompt-master 1>/dev/null
./install.sh
popd 1>/dev/null

rm -rf $temp 1>/dev/null