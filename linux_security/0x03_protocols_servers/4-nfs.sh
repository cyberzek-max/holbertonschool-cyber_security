#!/bin/bash
grep -v '^#' /etc/exports 2>/dev/null | grep -Ei '(\*|no_root_squash|insecure|rw.*no_root_squash)' && echo "[!] Potentially insecure NFS export found" || echo "No obviously insecure NFS exports detected"
