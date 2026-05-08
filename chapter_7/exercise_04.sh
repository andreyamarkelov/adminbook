#!/bin/bash

# Exercise 4: Use the ps command to identify the top 3 processes consuming the most CPU and memory.
#
# Task: List processes sorted by CPU and memory usage.

echo "=== Top 3 CPU-consuming processes ==="
ps aux --sort=-%cpu | head -n 4

echo ""
echo "=== Top 3 Memory-consuming processes ==="
ps aux --sort=-%mem | head -n 4
