#!/bin/bash 
threshold=80 
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}') 
if (( $(echo "$cpu > $threshold" | bc -l) )); then 
echo "[ALERT] High CPU Usage: $cpu%" 
fi 
Meaning:
