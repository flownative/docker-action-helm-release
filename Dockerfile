FROM ubuntu:latest

ENV HELM_VERSION=v3.16.1
ENV HELM_HOME=/root/.helm

RUN apt-get update \
    && apt-get install git curl -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/apt \
    && rm -rf /var/log/dpkg.log

# For Helm releases see: https://github.com/helm/helm/releases
RUN curl -sSL "https://get.helm.sh/helm-v3.16.1-linux-amd64.tar.gz" | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
