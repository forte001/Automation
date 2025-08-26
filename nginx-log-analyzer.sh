#!/bin/bash

# This script is a simple Nginx log analyzer that 
# output the IP addresses with the most requests,
# most requested paths, top response codes,
# and user agents

set -euo pipefail

LOG_URL=https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log 
LOG_FILE="/tmp/nginx-access.log"

# Download log file only once
echo "Downloading log file ..."
curl -s "$LOG_URL" -o "$LOG_FILE"
echo "Downloading log file successful!"
echo
# Top 5 IP addresses with the most requests
echo "Top 5 IP addresses with the most requests:"
grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){3}' "$LOG_FILE" \
  | sort \
  | uniq -c \
  | sort -nr \
  | awk '{print $2 " - " $1 " requests"}' \
  | head -n 5

echo
# Top most requested paths
echo "Top 5 most requested paths:"
awk -F\" '{print $2}' "${LOG_FILE}" \
| awk '{print $2}' \
|sort \
| uniq -c \
|sort -nr \
| head -n 5 \
| awk '{print $2 " - " $1 " requests"}' \

echo
# Top 5 response status codes
echo "Top 5 response status codes:"
awk '{print $9}' "${LOG_FILE}" \
| sort \
| uniq -c \
| sort -nr \
| awk '{print $2 " - " $1 " requests"}' \
| head -n 5

echo
# Top 5 user agents
echo "Top 5 user agents:"
awk '{print $11}' "${LOG_FILE}" \
|sort \
| uniq -c \
| sort -nr \
| awk '{print $2 " - " $1 " agents"}' \
| head -n 5

