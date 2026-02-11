#!/bin/bash
grep -E '^(PermitRootLogin|PasswordAuthentication|X11Forwarding|PermitEmptyPasswords|Protocol|MaxAuthTries|AllowTcpForwarding|PermitUserEnvironment|GSSAPIAuthentication|KerberosAuthentication)' /etc/ssh/sshd_config 2>/dev/null | grep -vE '^#|yes$|no$|sandbox$|prohibit-password$' | sed 's/^/[!] Non-standard or insecure: /'
