#! /usr/bin/env sh

set -e

apt-get update && apt-get install -y gosu sudo git
gosu nobody true

useradd --uid 1000 --user-group --system --create-home --no-log-init --groups tty --shell /bin/bash build
echo 'build ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
chown -R build:build /home/build
chmod u=rwx,g=rx,o= /home/build
