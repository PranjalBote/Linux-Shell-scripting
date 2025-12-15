#!/bin/bash 
echo "Top outbound connections:" 
netstat -tunp | grep ESTABLISHED | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | 
head
