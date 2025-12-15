#!/bin/bash 
echo "Users who used sudo recently:" 
grep "sudo" /var/log/auth.log | awk '{print $9}' | sort | uniq
