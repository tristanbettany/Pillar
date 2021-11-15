#!/bin/bash

if [ ! -f /ca/pillar-ca.key ]; then
  openssl genrsa \
      -des3 \
      -out /ca/pillar-ca.key \
      -passout pass:pillar 2048 \

    openssl req \
      -x509 \
      -new \
      -nodes \
      -key /ca/pillar-ca.key \
      -sha256 \
      -days 365 \
      -subj '/CN=Pillar/O=Pillar/C=GB' \
      -out /ca/pillar-ca.pem \
      -passin pass:pillar
fi

openssl genrsa \
  -out /ca/pillar.key 2048

openssl req \
  -new \
  -key /ca/pillar.key \
  -subj '/CN=Pillar/O=Pillar/C=GB' \
  -out /ca/pillar.csr

openssl x509 \
  -req \
  -in /ca/pillar.csr \
  -CA /ca/pillar-ca.pem \
  -CAkey /ca/pillar-ca.key \
  -CAcreateserial \
  -out /ca/pillar.crt \
  -days 365 \
  -sha256 \
  -extfile /etc/nginx/ssl.cnf \
  -passin pass:pillar

exec nginx -g 'daemon off;'