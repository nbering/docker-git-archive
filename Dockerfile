FROM debian:stretch

RUN mkdir -p /usr/bin

COPY ./container-entrypoint /usr/bin/

RUN apt-get update && \
    apt-get install -y git

ENTRYPOINT [ "/usr/bin/container-entrypoint" ]
