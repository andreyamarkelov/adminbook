#!/bin/bash

# Extra Exercise 2: Create a command pipeline that reads /etc/passwd, extracts 
# all unique shells (field 7), sorts them, and displays how many users use each shell.
#
# Task: Use cut, sort, uniq in a pipeline to analyze shell usage.

echo "Shell usage statistics from /etc/passwd:"
echo ""
cut -d: -f7 /etc/passwd | sort | uniq -c | sort -rn
