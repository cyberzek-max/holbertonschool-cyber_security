#!/bin/bash
grep -Ei 'public|private|community.*public|com2sec.*public' /etc/snmp/snmpd.conf 2>/dev/null | sed 's/^/[!] Possible public SNMP community: /' || echo "No public community strings found or snmpd.conf not present"
