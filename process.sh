#!/bin/bash

LOG_FILE="/var/log/dpkg.log"

DB_FILE="$HOME/.package_monitor.db"
TEMP_FILE="/tmp/pm_temp.db"

parse_logs() {
    grep -E " install | remove | purge | upgrade " "$LOG_FILE" | \
    awk '{print $1 " " $2 " " $3 " " $4}'
}

if [ -f "$DB_FILE" ]; then
    cat "$DB_FILE" > "$TEMP_FILE"
else
    touch "$DB_FILE"
    touch "$TEMP_FILE"
fi

parse_logs >> "$TEMP_FILE"

sort -u "$TEMP_FILE" > "$DB_FILE"
rm "$TEMP_FILE"