#!/bin/bash

# All scripts are executed within the kali container since it is acting as our testing black box

# Website handshake, list cipher suites, 
docker compose exec kali /bin/bash -c ./usr/local/services/kali/cybersec-check.sh
# Brute force the bcrypt hash of the basic auth in front of the webserver with john the ripper
# docker compose exec kali /bin/bash -c ./usr/local/services/kali/john-ripper.sh
