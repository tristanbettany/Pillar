FROM node:lts

ARG DEBIAN_FRONTEND=noninteractive

# Install Libs
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential git curl zip unzip openssl vim ssh && \
    apt-get -y autoremove && apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./package*.json /usr/src/app/
ADD ./server.js /usr/src/app/

RUN cd /usr/src/app && npm install

EXPOSE 8080
CMD [ "node", "/usr/src/app/server.js" ]