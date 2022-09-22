FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends \
               ca-certificates \
               curl \
               openssh-server

RUN useradd -s /bin/bash -md /home/k9tty k9tty \
    && echo "k9tty:password" | chpasswd

USER k9tty

RUN curl sL https://webinstall.dev/k9s | bash \
    && echo 'PATH=$PATH:~/.local/bin' >> ~/.profile \
    && echo 'k9s' >> ~/.profile

USER root

ADD ./entrypoint.sh /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
