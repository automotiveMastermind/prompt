#! /usr/bin/env sh

set -e

USERNAME=${1:-build}

if command -v apt-get 1>/dev/null 2>&1; then
	apt-get update
	apt-get --no-install-recommends install -y \
		sudo curl unzip
	rm -rf /var/lib/apt/lists/*
	rm -rf /var/cache/apt
fi

if command -v dnf 1>/dev/null 2>&1; then
	dnf update -y
	dnf install -y \
		sudo curl unzip
	dnf clean all
fi

useradd --uid 1000 --user-group --system --create-home --no-log-init --groups tty --shell /bin/sh "${USERNAME}"
printf "%s\n" "$USERNAME ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers

chown -R "${USERNAME}":"${USERNAME}" /home/"${USERNAME}"
chmod u=rwx,g=rx,o= /home/"${USERNAME}"
