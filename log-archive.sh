#!/bin/bash

# This script automatically archives logs and 
# keeps the sytem clean


# Exit on non-zero error
set -e

# Uninstall cron option
if [[ "${1:-}" == "--uninstall-cron" ]]; then
    crontab -l 2>/dev/null | grep -v "$(realpath "$0")" | crontab -
    echo "Cron job removed for $(realpath "$0")"
    exit 0
fi


#  default log directory
LOG_DIR=${1:-/var/log}
ARCHIVE_DIR="$LOG_DIR/archive"

# Create log directory if it's needed
mkdir -p "$ARCHIVE_DIR"


#Generate filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S") # create timestamp for file naming
ARCHIVE_FILE="$ARCHIVE_DIR/logs_archive_${TIMESTAMP}.tar.gz"


# Generate log archive
tar -czf "$ARCHIVE_FILE" --exclude "archive" -C "$LOG_DIR" .
echo "Log archiving successful!"
# Write log entry with date/time
echo "$(date '+%Y-%m-%d %H:%M:%S') Archived logs to $ARCHIVE_FILE" >> "$ARCHIVE_DIR/archive.log"

# check for and remove old log files
find "$ARCHIVE_DIR" -name "*.tar.gz" -mtime +30 -exec rm -f {} \;
echo "Log archive files older than 30 day have been removed"

#Setup cron job to run at 2AM daily
CRON_JOB="0 2 * * * $(realpath "$0") $LOG_DIR >/dev/null 2>&1"


#Check if crob job already exists
(crontab -l 2>/dev/null | grep -F "$(realpath "$0")" >/dev/null) || {
	echo "Installing cron job to run daily at 2 A.M"
	(crontab -l 2>/dev/null; echo "CRON_JOB") | crontab -
	echo "Cron job installed: $CRON_JOB"
	echo "Cron "
}

