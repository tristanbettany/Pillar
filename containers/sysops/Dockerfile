FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential software-properties-common git curl zip unzip openssl vim ssh less && \
    apt-get -y autoremove && apt-get -y autoclean

# Install NVM with Node LTS, Also install any node packages
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    # Install Node LTS using NVM
    && nvm install --lts \
    # Allow npm to run as root
    && npm config set user 0 && npm config set unsafe-perm true \
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

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install

COPY keys.sh /root
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh