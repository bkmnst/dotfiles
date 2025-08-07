#!/usr/bin/env bash

# Export certificates from MacOS keychain
security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain > ~/root_certs.pem
security find-certificate -a -p /Library/Keychains/System.keychain >> ~/root_certs.pem

# Not sure if this is MacOS specific...
mkdir -p ~/.docker/certs.d
mv ~/root_certs.pem ~/.docker/certs.d
