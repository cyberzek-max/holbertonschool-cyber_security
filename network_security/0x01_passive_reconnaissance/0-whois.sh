#!/bin/bash
whois $1 | awk '/Registrant|Admin|Tech/ && $0 ~ /:/ && !/URL/ {split($0,a,": "); print a[1] "," a[2]}' > $1.csv
