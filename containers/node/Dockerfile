FROM node:lts

ARG DEBIAN_FRONTEND=noninteractive

# Install Libs
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential git curl zip unzip openssl vim ssh && \
    apt-get -y autoremove && apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY keys.sh /root
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh

WORKDIR /usr/src/app

ADD ./package*.json ./
ADD ./server.js ./

RUN npm install

EXPOSE 8080
CMD [ "node", "server.js" ]