#!/bin/bash

# Extra Exercise 1: Use the find command to locate all files in /var/log that were 
# modified in the last 24 hours. Sort the results by modification time (newest first).
#
# Task: Find recently modified log files using find with -mtime.

echo "Files in /var/log modified in the last 24 hours (newest first):"
echo ""
find /var/log -type f -mtime -1 2>/dev/null | xargs ls -lt 2>/dev/null | head -20
