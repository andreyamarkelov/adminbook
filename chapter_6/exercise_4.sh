#!/bin/bash

# Exercise 4: Use the lsblk --fs or blkid commands to list all file systems 
# on your system and their corresponding UUIDs.
#
# Task: Display filesystem information for all block devices.

echo "=== Using lsblk --fs ==="
sudo lsblk --fs

echo ""
echo "=== Using blkid ==="
sudo blkid
