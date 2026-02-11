#!/bin/bash
grep -E '^(PermitRootLogin|PasswordAuthentication|X11Forwarding|PermitEmptyPasswords|Protocol|MaxAuthTries|AllowTcpForwarding)' /etc/ssh/sshd_config 2>/dev/null | grep -vE '^#|yes$|no$|sandbox$' | sed 's/^/[!] Non-standard or insecure: /'
