#!/bin/bash

# Ensure the /data and /backups directories exist
mkdir -p /data /backups

# Set the RESTIC_PASSWORD environment variable
export RESTIC_PASSWORD=$RESTIC_PASSWORD

# Check if the Restic repository is initialized, if not, initialize it
if [ ! -d "/backups/config" ]; then
    restic init --repo /backups
fi

# Backup MariaDB
restic backup /backup/mariadb --repo /backups --tag mariadb

# Backup WordPress
restic backup /backup/wordpress --repo /backups --tag wordpress

# Prune old backups
restic forget --repo /backups --keep-last 7 --keep-daily 30 --keep-weekly 12 --keep-monthly 3 --keep-yearly 2

# Cleanup
restic check --repo /backups
