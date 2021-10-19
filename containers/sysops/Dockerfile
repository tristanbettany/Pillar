FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential software-properties-common git curl zip unzip openssl vim ssh && \
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

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install

COPY keys.sh /root
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh