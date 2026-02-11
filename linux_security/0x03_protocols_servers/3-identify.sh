#!/bin/bash
command -v lynis >/dev/null && sudo lynis audit system --quiet | grep -Ei 'warning|weak|medium|high|critical' || echo "Lynis not found or no notable findings"
