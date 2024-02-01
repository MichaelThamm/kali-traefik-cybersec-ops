#!/bin/bash

results_folder="/usr/local/crypto-results"
ubuntu_folder="/usr/local/services/ubuntu"

# ---OpenSCAP---
oval_file="com.ubuntu.$(lsb_release -cs).usn.oval.xml"
wget -P "$ubuntu_folder" "https://security-metadata.canonical.com/oval/$oval_file.bz2"
bunzip2 "$ubuntu_folder/$oval_file.bz2"
rm "$ubuntu_folder/$oval_file.bz2"
oscap oval eval --report "$results_folder/oval-results.html" "$ubuntu_folder/$oval_file"
