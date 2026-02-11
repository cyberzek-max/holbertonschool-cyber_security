#!/bin/bash
whois "$1" 2>/dev/null | awk 'BEGIN{FS=":[ \t]*"} $1~/^Registrant /{s="Registrant"} $1~/^Admin /{s="Admin"} $1~/^Tech /{s="Tech"} s && $1~/^(Registrant|Admin|Tech) (Name|Organization|Street|City|State\/Province|Postal Code|Country|Phone|Phone Ext|Fax|Fax Ext|Email)$/{f=$1; sub(/^(Registrant|Admin|Tech)[ ]+/,"",f); if(f=="Street") printf "%s %s, %s ",s,f,$2; else if(f~/Phone Ext|Fax Ext/) printf "%s %s:, %s",s,f,$2; else printf "%s %s, %s",s,f,$2; c++; if(c<36) printf "\n"}' > "$1.csv"

