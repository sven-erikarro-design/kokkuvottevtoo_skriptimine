#!/usr/bin/env bash
set -u
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ $# -gt 1 ]]; then
    echo "Kasutus: $0 [ARHIIVI_TEE]" >&2
    exit 2
fi
if [[ $# -eq 1 ]]; then
    archive="$1"
else
    archive="$(find "$BASE_DIR/backups" -maxdepth 1 -type f -name 'backup_*.tar.gz' -printf '%T@ %p\n' 2>/dev/null | sort -nr | head -n 1 | cut -d' ' -f2-)"
fi
if [[ -z "$archive" || ! -f "$archive" ]]; then
    echo "Viga: varukoopiafaili ei leitud. Anna arhiivi tee argumendina." >&2
    exit 1
fi
if tar -tzf "$archive" >/dev/null 2>&1; then
    printf 'OK: arhiiv on loetav ja gzip/tar tervikluskontroll läbis: %s\n' "$archive"
    exit 0
else
    printf 'VIGA: arhiiv on vigane või pole gzip/tar arhiiv: %s\n' "$archive" >&2
    exit 1
fi
