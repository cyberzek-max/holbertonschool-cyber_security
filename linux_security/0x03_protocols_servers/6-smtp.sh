#!/bin/bash
grep -qiE 'smtpd_use_tls.*yes|smtpd_tls_security_level.*(may|encrypt)' /etc/postfix/main.cf 2>/dev/null && echo "STARTTLS appears configured" || echo "STARTTLS not configured"
