FROM ubuntu:22.10

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends ca-certificates curl gnupg lsb-release git

RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt update \
    && apt install -y docker-ce-cli docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN curl -fsSL https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux.amd64 -o /usr/bin/sops \
  && chmod +x /usr/bin/sops
