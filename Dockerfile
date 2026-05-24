FROM ubuntu:24.04

ARG TARGETARCH=amd64
ARG KUBECTL_VERSION=stable

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    bash-completion \
    bind9-dnsutils \
    ca-certificates \
    curl \
    default-mysql-client \
    iproute2 \
    iputils-ping \
    iputils-tracepath \
    jq \
    less \
    lsof \
    mtr-tiny \
    nano \
    net-tools \
    netcat-openbsd \
    nmap \
    openssl \
    postgresql-client \
    procps \
    redis-tools \
    socat \
    strace \
    tcpdump \
    telnet \
    traceroute \
    vim-tiny \
    wget \
    yq \
  && if [ "${KUBECTL_VERSION}" = "stable" ]; then \
      KUBECTL_VERSION="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"; \
    fi \
  && case "${TARGETARCH}" in \
      amd64|arm64) kubectl_arch="${TARGETARCH}" ;; \
      *) echo "Unsupported TARGETARCH: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
  && curl -fsSL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${kubectl_arch}/kubectl" \
  && chmod +x /usr/local/bin/kubectl \
  && kubectl completion bash > /etc/bash_completion.d/kubectl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
