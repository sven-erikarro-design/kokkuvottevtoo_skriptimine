#!/usr/bin/env bash
set -euo pipefail
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source "$BASE_DIR/config/settings.conf" *Varunduma peab ainult test data*
DATE="$(date '+%Y%m%d_%H%M%S')"
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"
if [[ ! -d "$BACKUP_SOURCE" ]]; then
    printf 'Viga: varundamise allikakausta pole: %s\\n' "$BACKUP_SOURCE" >&2
    exit 1
fi
mkdir -p "$BACKUP_DIR"
if ! tar -czf "$ARCHIVE" -C "$BACKUP_SOURCE" .; then
    rm -f -- "$ARCHIVE"
    echo "Varukoopia loomine ebaõnnestus." >&2
    exit 1
fi
if ! tar -tzf "$ARCHIVE" >/dev/null; then
    rm -f -- "$ARCHIVE"
    echo "Loodud varukoopia ei läbinud tervikluskontrolli." >&2
    exit 1
fi
printf 'Varukoopia valmis: %s\n' "$ARCHIVE"
printf 'Arhiivi kirjeid: %s\n' "$(tar -tzf "$ARCHIVE" | wc -l)"


