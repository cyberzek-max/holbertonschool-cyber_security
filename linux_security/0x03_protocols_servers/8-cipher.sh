#!/bin/bash
command -v nmap >/dev/null && sudo nmap --script ssl-enum-ciphers -p 443 localhost | grep -Ei 'weak|RC4|MD5|3DES|cbc|SSLv|TLSv1\.0|TLSv1\.1' || echo "nmap not found or no weak ciphers detected"
