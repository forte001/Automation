#!/bin/bash

### This is a CPU performance display statistic script

OS=$(uname)

echo "***** SYSTEM INFORMATION ******"
if [[ "$OS" == "Linux" ]]; then
	if command -v lsb_release >/dev/null 2>&1; then
		echo "OS Version: $(lsb_release -d | cut -f2)"
	else
		echo "OS Version: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
	fi
elif [[ "$OS" == "Darwin" ]]; then
	echo "OS Version: $(sw_vers -productName) $(sw_vers -productVersion)"
fi

### Uptime and load average
echo "Uptime and Load: $(uptime)"

### :Logged in users
echo "Logged in users:"
who

### Number of users
echo "Number of users: $(who | wc -l)"

### Failed login attempts
echo "Failed login attempts:"
if [[ "$OS" == "Linux" ]]; then
	if command -v lastb >/dev/null 2>&1; then
		lastb | head -n 5
		echo "Total failed login: $(lastb | wc -l)"
	else
		echo "No 'lastb' command available. Check /var/log/auth/log manually."
	fi
elif [[ "$OS" == "Darwin" ]]; then
	echo "(macOS doesn't support 'lastb' - checking system log for recent failures)"
	log show --predicate 'eventMessage contains "Failed"' --last 1d | head -n 5

fi



echo "***** CPU USAGE ******"

if [[ "$OS" == "Linux" ]]; then
	top -bn1 | grep "Cpu(s)"
elif [[ "$OS" == "Darwin" ]]; then
	top -l 1 | grep "CPU usage"
fi

echo "***** MEMORY USAGE ******"

if [[ "$OS" == "Linux" ]]; then
	free -h

elif [[ "$OS" == "Darwin" ]]; then
	vm_stat | awk 'NR>1 {gsub("\\.","")}; sum+=$3 END {print "Memory pages used:", sum}'
	top -l 1 | grep PhysMem

fi

echo "***** Top Processes by CPU *****"
if [[ "$OS" == "Linux" ]]; then
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 5
elif [[ "$OS" == "Darwin" ]]; then
    ps -Ao pid,ppid,command,%mem,%cpu | sort -k5 -nr | head -n 5
fi

echo "***** Top Processes by Memory *****"
if [[ "$OS" == "Linux" ]]; then
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 5
elif [[ "$OS" == "Darwin" ]]; then
    ps -Ao pid,ppid,command,%mem,%cpu | sort -k4 -nr | head -n 5
fi
