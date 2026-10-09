#!/usr/bin/env bash
set -euo pipefail
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source "$BASE_DIR/config/settings.conf"
mount_point="${1:-/}"
if [[ ! "$DISK_LIMIT" =~ ^[0-9]+$ ]] || (( DISK_LIMIT < 1 || DISK_LIMIT > 100 )); then
    echo "Viga: DISK_LIMIT peab olema täisarv vahemikus 1..100." >&2
    exit 2
fi
if ! df -P "$mount_point" >/dev/null 2>&1; then
    echo "Viga: failisüsteemi ei saa kontrollida: $mount_point" >&2
    exit 2
fi
usage="$(df -P "$mount_point" | awk 'NR==2 {gsub(/%/, "", $5); print $5}')"
if [[ ! "$usage" =~ ^[0-9]+$ ]]; then
    echo "Viga: df ei tagastanud kasutusprotsenti." >&2
    exit 2
fi
printf 'Kettakasutus (%s): %s%% (piir %s%%)\n' "$mount_point" "$usage" "$DISK_LIMIT"
if (( usage < DISK_LIMIT )); then
    echo "OK: kettaruumi kasutus on normis."
    exit 0
else
    echo "HOIATUS: kettaruumi kasutus on vähemalt piirväärtus."
    exit 1
fi
