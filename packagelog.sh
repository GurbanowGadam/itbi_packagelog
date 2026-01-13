#!/bin/bash

DB_FILE="$HOME/.package_monitor.db"

show_help() {
    echo "Analizează operațiunile pachetului software de sistem."
    echo ""
    echo "Options:"
    echo "  -i, --installed            : Listează pachetele INSTALATE în prezent pe sistem."
    echo "  -r, --removed              : Listează pachetele care au fost instalate anterior dar acum sunt REMOVED."
    echo "  -h, --history <pkg_name>   : Afișează istoricul complet al operațiilor pentru un anumit pachet."
    echo "  -t, --time <start> <end>   : Listează operațiile între două date (Format: YYYY-MM-DD)."
    echo ""
    echo "Example:"
    echo "  ./package_monitor.sh -t 2025-12-12 2026-01-05"
}


if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

case "$1" in
    -i|--installed)
        echo "=== PACHETE INSTALATE ÎN PREZENT ==="
        echo "-------------------------------------"

        awk '{
            status[$4] = $3; 
            last_date[$4] = $1 " " $2 
        } 
        END { 
            for (p in status) {
                if (status[p] == "install" || status[p] == "upgrade") 
                    print last_date[p], p 
            }
        }' "$DB_FILE" | sort
        ;;

    -r|--removed)
        echo "=== PACHETE ÎNDEPĂRTATE ==="
        echo "-------------------------------------"

        awk '{
            status[$4] = $3; 
            last_date[$4] = $1 " " $2 
        } 
        END { 
            for (p in status) {
                if (status[p] == "remove" || status[p] == "purge") 
                    print last_date[p], p 
            }
        }' "$DB_FILE" | sort
        ;;

    -h|--history)
        PACKAGE_NAME="$2"
        if [ -z "$PACKAGE_NAME" ]; then
            echo "Eroare: Trebuie să specificați un nume de pachet."
            exit 1
        fi
        echo "=== ISTORIC PENTRU PACHETUL: $PACKAGE_NAME ==="
        grep "$PACKAGE_NAME" "$DB_FILE"
        
        if [ $? -ne 0 ]; then
            echo "Nu s-au găsit înregistrări pentru acest pachet."
        fi
        ;;

    -t|--time)
        START="$2"
        END="$3"
        if [ -z "$START" ] || [ -z "$END" ]; then
            echo "Eroare: Trebuie să furnizați datele de început și de sfârșit (AAAA-LL-ZZ)."
            exit 1
        fi
        echo "=== OPERAȚII ÎNTRE $START ȘI $END ==="
        awk -v s="$START" -v e="$END" '$1 >= s && $1 <= e { print $0 }' "$DB_FILE"
        ;;

    *)
        echo "Opțiune nevalidă: $1"
        show_help
        exit 1
        ;;
esac