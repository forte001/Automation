#!/bin/bash
# cleanup.sh
# Script to remove Netdata, stress-ng, and related configs

set -e

echo "=== Cleaning up system monitoring setup ==="

# Stop Netdata if running
if systemctl is-active --quiet netdata; then
    echo "Stopping Netdata service..."
    sudo systemctl stop netdata
fi

# Disable Netdata from autostart
if systemctl is-enabled --quiet netdata; then
    echo "Disabling Netdata service..."
    sudo systemctl disable netdata
fi

# Uninstall Netdata depending on how it was installed
if [ -x "$(command -v apt)" ]; then
    echo "Removing Netdata and stress-ng (apt)..."
    sudo apt purge -y netdata stress-ng || true
    sudo apt autoremove -y
elif [ -x "$(command -v yum)" ]; then
    echo "Removing Netdata and stress-ng (yum)..."
    sudo yum remove -y netdata stress-ng || true
elif [ -x "$(command -v brew)" ]; then
    echo "Removing Netdata and stress-ng (brew)..."
    brew uninstall netdata stress-ng || true
fi

# Remove leftover Netdata files
echo "Removing Netdata config & data directories..."
sudo rm -rf /etc/netdata /var/lib/netdata /var/cache/netdata /usr/lib/netdata /var/log/netdata

# Remove Netdata kickstart script if still present
rm -f /tmp/netdata-kickstart.sh

echo "=== Cleanup complete! System is back to clean state. ==="
