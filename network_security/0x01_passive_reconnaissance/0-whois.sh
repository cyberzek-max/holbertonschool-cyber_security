#!/usr/bin/env bash
whois "$1" 2>/dev/null | awk 'BEGIN{FS=":[ \t]*"}$1~/^Registrant/{s="Registrant"}$1~/^Admin/{s="Admin"}$1~/^Tech/{s="Tech"}{if(s){f=$1;sub(/^(Registrant|Admin|Tech) /,"",f);if(f=="Street")print s" "f","$2" ";else if(f~/Phone Ext|Fax Ext/)print s" "f":,"$2;else print s" "f","$2}}' >"$1.csv"
