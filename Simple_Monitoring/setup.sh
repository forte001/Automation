#!/bin/bash

# This tool sets up monitoring of Netdata on a Linux system
# starting from it's installation to set up of alarm system


set -e

# Update system packages
echo "============= Updating System packages ============"

if  command -v apt-get >/get/null 2>&1; then
	sudo apt-get update -y
	sudo apt install -y curl net-tools
elif command -v yum >/get/null 2>&1; then
	sudo yum makecache
	sudo yum install -y curl net-tools
elif command -v dnf >/get/null 2>&1; then
	sudo dnf makecache
	sudo dnf install -y curl net-tools
else
	echo "Unsupported package manager. Please install curl manually."
fi

# Install Netdata
echo "============= Installing Netdata ============"
curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh
sh /tmp/netdata-kickstart.sh --disable-telemetry

echo "============= Installation of Netdata complete ============"
echo "Access the dashboard at: http://$(hostname -I | awk '{print $1}'): 19999"

# Custom alarm config
NETDATA_CONF_DIR="/etc/netdata/health.d"

sudo mkdir -p "$NETDATA_CONF_DIR"
sudo tee "$NETDATA_CONF_DIR/system.conf" > /dev/null <<EOF
# ============================
# CPU Alarm
# ============================
alarm: cpu_usage
on: system.cpu
lookup: average -1m unaligned of user, system
units: %
every: 10s
warn: \$this > 75
crit: \$this > 85
info: Average CPU usage is too high

# ===============================
# Memory Alarm
# ===============================
alarm: memory_usage
on: system.ram
lookup: average -1m unaligned of used
units: %
every: 10s
warn: \$this > 75
crit: \$this > 90
info: Memory usage is too high

# ===============================
# Disk I/O Alarm
# ===============================
alarm: disk_io
on: system.io
lookup: average -1m unaligned of received, sent
units: %
every: 10s
warn: \$this > 75
crit: \$this > 90
info: Disk I/O utilization too high

# ===============================
# Network Usage Alarm
# ===============================
alarm: net_bandwidth
on: system.net
lookup: average -1m unaligned of used
units: kilobits
every: 10s
warn: \$this > 100000 # ~100 Mbps
crit: \$this > 900000 # ~900 Mbps
info: Network traffic too high
EOF

echo "===== Custom alarms for CPU, Memory, Disk I/O, and Network set. ==="

sudo systemctl restart netdata

echo "=== Netdata is running. Visit http://$(hostname -I | awk '{print $1}'):19999 ==="