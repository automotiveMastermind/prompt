FROM fedora:29

RUN dnf install -y glibc-locale-source sudo util-linux-user \
    && dnf clean all \
    && localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && useradd -m -s /bin/bash am-prompt \
    && echo 'am-prompt ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER am-prompt
WORKDIR /home/am-prompt

ENV LANG=en_US.UTF-8 \
    USER=am-prompt

COPY . ./
RUN ./install.sh

SHELL [ "/bin/bash", "-l" ]
RUN git-sha
