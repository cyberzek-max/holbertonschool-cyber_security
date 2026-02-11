#!/bin/bash
grep -Ri 'starttls' /etc/postfix /etc/exim* 2>/dev/null || echo "STARTTLS not configured"
