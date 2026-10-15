#!/usr/bin/env bash
set -u

service="${1:-}"

if [[ -z "$service" ]]; then
    echo "Kasutus: $0 TEENUS" >&2
    exit 2
fi

if ! command -v systemctl >/dev/null 2>&1; then
    echo "Viga: systemctl pole saadaval." >&2
    exit 2
fi

if systemctl is-active --quiet -- "$service"; then
    printf 'Teenus %s on aktiivne.\n' "$service"
    exit 0
else
    state="$(systemctl is-active -- "$service" 2>/dev/null || true)"
    printf 'Teenus %s ei ole aktiivne (olek: %s).\n' \
        "$service" "${state:-unknown}"
    exit 1
fi
