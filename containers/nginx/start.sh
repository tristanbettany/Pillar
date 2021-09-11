#!/bin/bash

if [ ! -f /ca/pillar.crt ]; then
  openssl req -x509 -new -nodes -days 365 \
   -keyout /ca/pillar.key \
   -out /ca/pillar.crt \
   -config /etc/nginx/ssl.cnf
fi

exec nginx -g 'daemon off;'