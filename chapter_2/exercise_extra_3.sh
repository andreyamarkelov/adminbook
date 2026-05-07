#!/bin/bash

# Extra Exercise 3: Use the head and tail commands together to extract lines 10-20
# from /etc/passwd. Then use sed to achieve the same result.
#
# Task: Extract a range of lines from a file using different methods.

echo "=== Using head and tail ==="
head -20 /etc/passwd | tail -11

echo ""
echo "=== Using sed ==="
sed -n '10,20p' /etc/passwd

echo ""
echo "=== Using awk ==="
awk 'NR>=10 && NR<=20' /etc/passwd
