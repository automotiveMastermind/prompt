FROM fedora:29

RUN dnf install -y glibc-locale-source sudo util-linux-user \
    && dnf clean all \
    && localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && useradd -m -s /bin/bash am-prompt \
    && echo 'am-prompt ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

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
