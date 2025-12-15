#!/bin/bash 
log="/var/log/auth.log" 
echo "Top 10 IPs with failed SSH logins:" 
grep "Failed password" $log | awk '{print $11}' | sort | uniq -c | sort -nr | head 
