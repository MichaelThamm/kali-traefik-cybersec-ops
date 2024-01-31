# kali-traefik-cybersec-ops
An integrated containerized environment using Kali Linux to securely attack a Traefik reverse proxy with hybrid encryption for cybersecurity experimentation and network operations

## Part 1 - Import Custom CA Certificate Into a Browser
The purpose of this is to avoid the need for a public domain and server
1. Execute:
   create-certs.sh
   1. This will create the ca-cert.crt certificate
2. Open your browser (tested with Firefox) and navigate to the privacy and security settings
   1. Here you can find the certificates store and import the ca-cert.crt
   2. Your browser will then trust anything signed with this ca-cert.crt (domain names in this example)

## Part 2 - Instantiate Containerization Environment
1. Execute:
   docker compose up -d
   2. This will create and start the containers defined in the docker-compose.yml file.

## Part 3 - Cybersecurity & Cryptography
Description: (TLS1.3-X.509)-(ECDHE-X25519)-(RSA-PSS-RSAE-SHA256)-(AES-256-GCM)