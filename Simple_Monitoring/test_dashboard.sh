#!/bin/bash
# test_dashboard.sh
# Script to put load on CPU, Memory, Disk, and Network to test Netdata alarms

set -e

echo "=== Starting system stress test to trigger Netdata alarms ==="

# Check if stress-ng is installed; install if missing
if ! command -v stress-ng &> /dev/null; then
    echo "Installing stress-ng..."
    if [ -x "$(command -v apt)" ]; then
        sudo apt update && sudo apt install -y stress-ng
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y epel-release && sudo yum install -y stress-ng
    elif [ -x "$(command -v brew)" ]; then
        brew install stress-ng
    else
        echo "Please install stress-ng manually for your system."
        exit 1
    fi
fi

# Run stress test in background for 2 minutes
echo "Stressing CPU..."
stress-ng --cpu 4 --timeout 120s &

echo "Stressing Memory..."
stress-ng --vm 2 --vm-bytes 80% --timeout 120s &

echo "Stressing Disk I/O..."
stress-ng --hdd 2 --hdd-bytes 1G --timeout 120s &

echo "Generating Network traffic (loopback)..."
# 100MB of traffic through localhost
dd if=/dev/zero bs=1M count=100 | nc -N 127.0.0.1 9999 &

# Sleep until tests complete
wait

echo "=== Stress test completed. Check Netdata dashboard for alarms. ==="
