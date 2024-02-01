#!/bin/bash

# All scripts are executed within the ubuntu container

# OpenSCAP using OVAL and XCCDF
docker compose exec ubuntu /bin/bash -c ./usr/local/services/ubuntu/cybersec-audit.sh
