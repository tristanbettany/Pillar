FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential software-properties-common git curl zip unzip openssl vim ssh less zsh && \
    apt-get -y autoremove && apt-get -y autoclean

# NVM / Node
RUN mkdir /usr/local/nvm

ENV NODE_VERSION 16.13.0
ENV NVM_DIR /usr/local/nvm
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION

RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH

RUN npm config set user 0 && npm config set unsafe-perm true \
    # Install Serverless npm package
    && npm install -g serverless serverless-domain-manager

# Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

# Install helmfile
RUN curl -fsSL -o helmfile https://github.com/roboll/helmfile/releases/download/v0.141.0/helmfile_linux_arm64 \
    && chmod +x ./helmfile \
    && mv helmfile /usr/local/bin/helmfile

# Install Digital Ocean Tool
RUN curl -fsSL -o doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.65.0/doctl-1.65.0-linux-amd64.tar.gz \
    && tar xf ./doctl.tar.gz \
    && chmod +x ./doctl \
    && mv ./doctl /usr/local/bin/doctl

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install

COPY keys.sh /root
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh