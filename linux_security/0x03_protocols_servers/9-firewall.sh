#!/bin/bash
iptables -F && iptables -P INPUT DROP && iptables -P FORWARD DROP && iptables -P OUTPUT ACCEPT && \
iptables -A INPUT -i lo -j ACCEPT && \
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT && \
iptables -A INPUT -p tcp --dport 22 -j ACCEPT && \
iptables -L -v -n --line-numbers | wc -l | grep -q '^3$' && echo "Basic firewall (INPUT: 3 rules) applied" || echo "Rule count mismatch"
