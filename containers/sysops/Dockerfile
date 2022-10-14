FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_NAME
ARG GROUP_NAME
ARG USER_ID
ARG GROUP_ID
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential gnupg software-properties-common git curl zip unzip openssl vim ssh less zsh jq && \
    apt-get -y autoremove && apt-get -y autoclean

RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} \
    && useradd ${USER_NAME} -u ${USER_ID} -g ${USER_ID} -m -s /bin/bash \
    && echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

# NVM / Node
RUN runuser -l ${USER_NAME} -c "curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
RUN runuser -l ${USER_NAME} -c "source ~/.nvm/nvm.sh && nvm install --lts && npm install -g serverless serverless-domain-manager"

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update && apt-get install terraform

RUN runuser -l ${USER_NAME} -c "terraform -install-autocomplete"

# Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

# Install helmfile
RUN curl -fsSL -o helmfile https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64 \
    && chmod +x ./helmfile \
    && mv helmfile /usr/local/bin/helmfile

# Install Digital Ocean Tool
RUN curl -fsSL -o doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.76.2/doctl-1.76.2-linux-amd64.tar.gz \
    && tar xf ./doctl.tar.gz \
    && chmod +x ./doctl \
    && mv ./doctl /usr/local/bin/doctl

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install

RUN runuser -l ${USER_NAME} -c "aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID"
RUN runuser -l ${USER_NAME} -c "aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY"
RUN runuser -l ${USER_NAME} -c "aws configure set region $AWS_DEFAULT_REGION"
RUN runuser -l ${USER_NAME} -c "aws configure set output json"

ADD ./scripts/ddb /usr/local/bin