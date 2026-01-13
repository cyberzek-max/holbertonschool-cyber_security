#!/bin/bash
[ "$#" -ne 3 ] && { echo "Usage: $0 <NEW_HOST> <TARGET_URL> <FORM_DATA>"; exit 1; }; curl -i -X POST "$2" -H "Host: $1" -H "Content-Type: application/x-www-form-urlencoded" --data "$3"
