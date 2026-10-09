#!/usr/bin/env bash
username="${1:-}"
if [[ -z "$username" ]]; then
    echo "Kasutus: $0 KASUTAJANIMI" >&2
    exit 2
fi
if getent passwd "$username" >/dev/null; then
    printf 'Kasutaja %s eksisteerib.\\n' "$username"
    exit 0
else
    printf 'Kasutajat %s ei leitud.\\n' "$username"
    exit 1
fi
