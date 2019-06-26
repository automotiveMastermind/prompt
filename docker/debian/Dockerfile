FROM debian:9

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends sudo locales uuid-runtime \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure locales \
    && update-locale LANG=en_US.UTF-8 \
    && useradd -m -s /bin/bash am-prompt \
    && echo 'am-prompt ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER am-prompt
WORKDIR /home/am-prompt/src

ENV LANG=en_US.UTF-8 \
    USER=am-prompt

COPY . ./
RUN ./install.sh

SHELL [ "/bin/bash", "-l" ]
RUN git-sha
