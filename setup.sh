#!/bin/bash

LINK_NAME="packagelog"
BACKEND_SCRIPT="process.sh"
FRONTEND_SCRIPT="packagelog.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FULL_PATH_BACKEND="$SCRIPT_DIR/$BACKEND_SCRIPT"
FULL_PATH_FRONTEND="$SCRIPT_DIR/$FRONTEND_SCRIPT"

if [ ! -f "$FULL_PATH_BACKEND" ]; then
    echo "Eroare: Eroare la fișierul „$BACKEND_SCRIPT"
    exit 1
fi

if [ ! -f "$FULL_PATH_FRONTEND" ]; then
    echo "Eroare: Eroare la fișierul „$FULL_PATH_FRONTEND"
    exit 1
fi

chmod +x "$FULL_PATH_BACKEND"
"$FULL_PATH_BACKEND"

CRON_JOB="0 * * * * $FULL_PATH --monitor"
CURRENT_CRON=$(crontab -l 2>/dev/null)


if echo "$CURRENT_CRON" | grep -Fq "$FULL_PATH"; then
    echo "Cron job-ul există deja. Nu a fost adăugat din nou."
else
    (echo "$CURRENT_CRON"; echo "$CRON_JOB") | crontab -
    echo "Cron adăugată."
fi

# --------------------------- #
TARGET_LINK="/usr/local/bin/$LINK_NAME"
sudo ln -sf "$FULL_PATH_FRONTEND" "$TARGET_LINK"

echo "Instalare finalizată"