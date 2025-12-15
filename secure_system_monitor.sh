#!/bin/bash

# 
#   SAFE LINUX SECURITY + LOG MONITOR SCRIPT
# 

LOGDIR="$HOME/security_monitor"
mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/scan_$(date +%F_%H-%M).log"

echo "===== SECURITY SCAN STARTED: $(date) =====" >> "$LOGFILE"


# 1. TOP CPU PROCESSES

echo "[1] Top CPU Processes:" >> "$LOGFILE"
ps -eo pid,ppid,%cpu,cmd --sort=-%cpu | head -n 10 >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


# 2. TOP RAM PROCESSES

echo "[2] Top RAM Processes:" >> "$LOGFILE"
ps -eo pid,ppid,%mem,cmd --sort=-%mem | head -n 10 >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


# 3. WORLD-WRITABLE FILE CHECK
# (Files writable by everyone; risky)

echo "[3] World-Writable Files:" >> "$LOGFILE"
find / -type f -perm /002 2>/dev/null | head -n 20 >> "$LOGFILE"
echo "(showing only first 20 entries)" >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


# 4. CHECK FILE CHANGES IN /etc (last 15 mins)

echo "[4] Recently Modified System Files (/etc):" >> "$LOGFILE"
find /etc -type f -mmin -15 2>/dev/null >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


# 5. CHECK CURRENTLY LOGGED-IN USERS

echo "[5] Active Users:" >> "$LOGFILE"
who >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


# 6. ACTIVE NETWORK CONNECTIONS

echo "[6] Network Connections:" >> "$LOGFILE"
ss -tulpn 2>/dev/null >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


# 7. IMPORTANT FILE PERMISSIONS CHECK

echo "[7] Important System File Permissions:" >> "$LOGFILE"
ls -l /etc/passwd /etc/shadow /etc/sudoers 2>/dev/null >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


# 8. CHECK FAILED AUTHENTICATION ATTEMPTS

echo "[8] Failed Login Attempts:" >> "$LOGFILE"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -n 10 >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"


echo "===== SECURITY SCAN COMPLETE =====" >> "$LOGFILE"
echo "Logs saved to: $LOGFILE"
