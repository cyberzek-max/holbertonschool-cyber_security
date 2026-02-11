grep -Ev '^(#|$)' /etc/ssh/sshd_config | grep -Ev '^(Port 22|PermitRootLogin no|PasswordAuthentication no|PubkeyAuthentication yes|Protocol 2)$'
