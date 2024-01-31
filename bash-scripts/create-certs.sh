#!/bin/bash

KEYS_DIR="services/traefik/keys"
mkdir -p "$KEYS_DIR"

# Create a root CA key and certificate
openssl genpkey -algorithm RSA -out $KEYS_DIR/ca-key.key
openssl req -new -key $KEYS_DIR/ca-key.key -x509 -days 365 -out $KEYS_DIR/ca-certificate.crt -config $KEYS_DIR/ca.conf

# Create a server auth key and CSR
openssl genpkey -algorithm RSA -out $KEYS_DIR/server-key.key
openssl req -new -key $KEYS_DIR/server-key.key -out $KEYS_DIR/server.csr -config $KEYS_DIR/server.conf

# Sign the code signing CSR with CA
openssl x509 -req -in $KEYS_DIR/server.csr -CA $KEYS_DIR/ca-certificate.crt -CAkey $KEYS_DIR/ca-key.key -CAcreateserial -out $KEYS_DIR/server-cert.crt -days 365 -extensions v3_req -extfile $KEYS_DIR/server.conf

# GnuTLS certificate
openssl req -x509 -newkey rsa:2048 -keyout server-cert.crt -out cert.pem -days 365
