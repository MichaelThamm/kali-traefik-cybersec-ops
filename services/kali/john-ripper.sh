#!/bin/bash

stripped_pswd="${FE_CREDENTIALS#sandbox:}"
results_folder="/usr/local/crypto-results"
kali_folder="/usr/local/services/kali"

echo "$stripped_pswd" > "$results_folder/pswd-hash.txt"
john --format=bcrypt --incremental "$results_folder/pswd-hash.txt"
john --show "$results_folder/pswd-hash.txt"
