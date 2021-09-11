FROM nginx:latest

ADD ./config/vhosts /etc/nginx/conf.d
ADD ./config/ssl.cnf /etc/nginx/ssl.cnf

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq openssl && \
    mkdir /ca

ADD start.sh /start.sh

CMD /bin/bash /start.sh