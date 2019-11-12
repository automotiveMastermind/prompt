FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends sudo locales uuid-runtime; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    localedef -i en_US -f UTF-8 en_US.UTF-8; \
    useradd -m -s /bin/bash am-prompt; \
    echo 'am-prompt ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER am-prompt
WORKDIR /home/am-prompt

ENV LANG=en_US.UTF-8 \
    USER=am-prompt \
    AM_PROMPT_UPDATE=0

COPY . ./

# install bash
RUN set -ex; \
    ./install.sh bash

# smoke test bash
RUN echo "$SHELL" | grep "/home/linuxbrew/.linuxbrew/bin/bash";

# smoke test prompt
RUN ["/home/linuxbrew/.linuxbrew/bin/bash", "-lc", "git-sha"]

# install zsh
RUN set -ex; \
    ./install.sh zsh

# smoke test zsh
RUN echo "$SHELL" | grep "/home/linuxbrew/.linuxbrew/bin/zsh";

# smoke test prompt
RUN ["/home/linuxbrew/.linuxbrew/bin/zsh", "-lc", "git-sha"]
