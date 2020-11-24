#! /usr/bin/env sh

set -e

gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64"
curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64.asc"
gpg --verify /usr/local/bin/gosu.asc
chmod +x /usr/local/bin/gosu
gosu nobody true

yum update -y && yum install -y sudo

useradd --uid 1000 --user-group --system --create-home --no-log-init \--groups tty --shell /bin/bash build
echo 'build ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
chown -R build:build /home/build
chmod u=rwx,g=rx,o= /home/build
