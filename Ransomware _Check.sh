#!/bin/bash 
echo "Files modified in the last 5 minutes:" 
find / -type f -mmin -5 2>/dev/null 
