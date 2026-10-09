#!/usr/bin/env bash
set -euo pipefail
echo "=== Süsteemi info ==="
printf 'Hostname: %s\\n' "$(hostname)"
printf 'Kasutaja: %s\\n' "$(id -un)"
printf 'Kernel: %s\\n' "$(uname -r)"
printf 'Arhitektuur: %s\\n' "$(uname -m)"
printf 'Uptime: %s\\n' "$(uptime -p 2>/dev/null || awk '{printf "%d sekundit", $1}' /proc/uptime)"
if command -v free >/dev/null 2>&1; then
    free -h | awk '/^Mem:/ {printf "Mälu kokku: %s\\n", $2}'
else
    awk '/MemTotal/ {printf "Mälu kokku: %.1f MiB\\n", $2/1024}' /proc/meminfo
fi
