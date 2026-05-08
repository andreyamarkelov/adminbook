#!/bin/bash

# Exercise 1: Use the parted command to create a new GPT partition table on a disk (e.g., /dev/sdb) 
# and then create a new primary partition using 30% of the available space. 
# Format this partition with the XFS file system.
#
# Task: Create GPT partition table, partition, and format with XFS.
#
# WARNING: This will erase all data on the disk. Use with caution!

echo "This script demonstrates the parted commands needed."
echo "Run: sudo parted /dev/sdb"
echo ""
echo "Commands to enter in parted:"
echo "mktable gpt         - Create GPT partition table"
echo "mkpart primary xfs 0% 30%  - Create partition using 30% of space"
echo "print               - Display partition table"
echo "quit                - Exit parted"
echo ""
echo "Then format the partition:"
echo "sudo mkfs.xfs /dev/sdb1"
