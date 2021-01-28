ARG IMAGE=debian
ARG VERSION=latest
FROM ${IMAGE}:${VERSION}

ARG PROMPT_SHELL=bash

WORKDIR /repo
COPY . .

RUN ./hack/pre.sh prompt
USER prompt

RUN set -ex; \
    ./install.sh ${PROMPT_SHELL}; \
    ./hack/clean.sh --force;

WORKDIR /home/prompt
ENTRYPOINT [ "$SHELL" ]
CMD [ "-l" ]
