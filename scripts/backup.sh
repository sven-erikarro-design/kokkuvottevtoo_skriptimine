#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/config/settings.conf"

if [ ! -d "$BACKUP_SOURCE" ]; then
    echo "Lähtekausta ei leitud."
    exit 1
fi

mkdir -p "$BACKUP_DIR"

DATE=$(date '+%Y%m%d_%H%M%S')
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

if tar -czf "$ARCHIVE" -C "$BACKUP_SOURCE" .; then
    echo "Varukoopia valmis: $ARCHIVE"
    exit 0
else
    echo "Varukoopia ebaõnnestus."
    exit 1
fi
