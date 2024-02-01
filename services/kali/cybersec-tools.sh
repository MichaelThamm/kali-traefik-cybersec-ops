#!/bin/bash

webserverDN="www.michaelthamm.com"
results_folder="/usr/local/crypto-results"
kali_folder="/usr/local/services/kali"

# ---GPG---
plaintext="I will become an HMAC!"

# Generate a Random 32 Bit Key
key=$(gpg --gen-random 1 32 | base64)
echo "Generated Key: $key"

# Calculate HMAC (Hash-Based Message Authentication Code)
echo -e "\nSHA256 HMAC (base64 format) - Before Encryption:"
hmac_before=$(echo -n "$plaintext" | openssl dgst -sha256 -hmac "$key" -binary | base64)
echo "$hmac_before"

# Encrypt Data Using AES
encrypted=$(echo -n "$plaintext" | gpg --batch --yes --symmetric --cipher-algo AES256 --passphrase "$key" | base64)

# Decrypt Data Using AES
echo -e "\nAES256 Ciphertext (base64 format):\n$encrypted"
echo -e "\nDecrypted Message:"
decrypted=$(echo -n "$encrypted" | base64 --decode | gpg --batch --yes --quiet --decrypt --passphrase "$key")
echo "$decrypted"

# Calculate HMAC (Hash-Based Message Authentication Code)
echo -e "\nSHA256 HMAC (base64 format) - After Decryption:"
hmac_after=$(echo -n "$plaintext" | openssl dgst -sha256 -hmac "$key" -binary | base64)
echo "$hmac_after"
if [ "$hmac_before" == "$hmac_after" ]; then
    echo -e "\nThe hashes are identical, validating integrity!"
fi


# ---GnuTLS---
# Check Cipher Suites Supported by a Server
gnutls-cli --insecure "$webserverDN" --list > "$results_folder/website-cipher-suites.md"

# Perform Handshake with a Server and Retrieve Certificate Information
echo -n "exit" | gnutls-cli --insecure "$webserverDN" --save-cert="$results_folder/website-handshake-cert.md"
