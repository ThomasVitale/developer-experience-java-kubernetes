FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install httpie && \
    rm -Rf /var/lib/apt/lists/*  && \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man  && \
    apt-get clean
