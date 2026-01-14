# Package Log Analyzer (English)

A simple command-line utility for Debian-based systems to track and query the history of software packages (installations, removals, upgrades).

## Features

*   **Log Parsing**: Automatically parses `/var/log/dpkg.log` to build a history of package operations.
*   **Query Interface**: A simple command-line tool (`packagelog`) to query the package history.
*   **List Installed Packages**: View all packages currently marked as installed.
*   **List Removed Packages**: View packages that have been removed or purged.
*   **Package History**: See the complete timeline of operations for a specific package.
*   **Time-Based Search**: Filter package operations within a specific date range.
*   **Automated Updates**: A cron job keeps the package database updated automatically.

## How It Works

1.  `process.sh`: This script reads `/var/log/dpkg.log`, extracts relevant package events, and stores them in a local database file (`~/.package_monitor.db`).
2.  `setup.sh`: This installation script sets up a cron job to run `process.sh` periodically, ensuring the database is kept up-to-date. It also creates a system-wide command `packagelog`.
3.  `packagelog`: This is the command-line interface that allows you to query the information collected by `process.sh`.

## Installation

Run the setup script to install the utility:
```bash
./setup.sh
```

## Usage

After installation, you can use the `packagelog` command:

```bash
# Show help
packagelog

# List currently installed packages
packagelog -i

# List removed packages
packagelog -r

# Show history for a specific package (e.g., "nano")
packagelog -h nano

# List operations between two dates
packagelog -t 2025-12-01 2026-01-01
```

---

# Analizor Jurnal Pachete (Română)

O unealtă simplă în linia de comandă pentru sisteme bazate pe Debian, pentru a urmări și interoga istoricul pachetelor software (instalări, eliminări, actualizări).

## Funcționalități

*   **Parsare Jurnal**: Parsează automat `/var/log/dpkg.log` pentru a construi un istoric al operațiunilor cu pachete.
*   **Interfață de Interogare**: O unealtă simplă în linia de comandă (`packagelog`) pentru a interoga istoricul pachetelor.
*   **Listare Pachete Instalate**: Vizualizați toate pachetele marcate în prezent ca fiind instalate.
*   **Listare Pachete Eliminate**: Vizualizați pachetele care au fost eliminate sau purjate.
*   **Istoric Pachet**: Vedeți cronologia completă a operațiunilor pentru un anumit pachet.
*   **Căutare după Dată**: Filtrați operațiunile cu pachete într-un interval de date specific.
*   **Actualizări Automate**: Un job cron menține baza de date a pachetelor actualizată automat.

## Cum Funcționează

1.  `process.sh`: Acest script citește `/var/log/dpkg.log`, extrage evenimentele relevante ale pachetelor și le stochează într-un fișier local de baze de date (`~/.package_monitor.db`).
2.  `setup.sh`: Acest script de instalare configurează un job cron pentru a rula `process.sh` periodic, asigurând că baza de date este menținută la zi. De asemenea, creează o comandă la nivel de sistem, `packagelog`.
3.  `packagelog`: Aceasta este interfața liniei de comandă care vă permite să interogați informațiile colectate de `process.sh`.

## Instalare

Rulați scriptul de configurare pentru a instala unealta:
```bash
./setup.sh
```

## Utilizare

După instalare, puteți utiliza comanda `packagelog`:

```bash
# Afișează ajutorul
packagelog

# Listează pachetele instalate în prezent
packagelog -i

# Listează pachetele eliminate
packagelog -r

# Afișează istoricul pentru un pachet specific (de ex., "nano")
packagelog -h nano

# Listează operațiunile între două date
packagelog -t 2025-12-01 2026-01-01
```