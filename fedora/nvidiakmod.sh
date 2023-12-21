#!/bin/sh
sudo dnf install akmods -y
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
