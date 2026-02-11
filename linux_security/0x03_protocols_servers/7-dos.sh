#!/bin/bash
command -v hping3 >/dev/null && sudo hping3 -S --flood -p 80 127.0.0.1 || echo "hping3 not installed"
