#!/bin/bash

# Exercise 1: Assuming you have a new, unpartitioned 20Gb disk named /dev/sdb. 
# Use fdisk /dev/sdb to enter the interactive mode. Create a new DOS (MBR) partition table for the disk. 
# Create one primary partition of 2 Gb and one extended partition. 
# Within the extended partition, create two logical partitions of 500 MiB each.
#
# Task: Create MBR partition table with primary and logical partitions using fdisk.
#
# WARNING: This script requires a disk device and will modify it. Use with caution!

echo "This script demonstrates the fdisk commands needed."
echo "Run: sudo fdisk /dev/sdb"
echo ""
echo "Commands to enter in fdisk:"
echo "n          - Create new partition"
echo "p          - Primary partition"
echo "1          - Partition number 1"
echo "[Enter]    - First sector (default)"
echo "+2G        - Size of 2GB"
echo ""
echo "n          - Create new partition"
echo "e          - Extended partition"
echo "2          - Partition number 2"
echo "[Enter]    - First sector (default)"
echo "[Enter]    - Last sector (use remaining space)"
echo ""
echo "n          - Create logical partition"
echo "[Enter]    - Accept logical partition"
echo "[Enter]    - First sector (default)"
echo "+500M      - Size of 500MB"
echo ""
echo "n          - Create logical partition"
echo "[Enter]    - Accept logical partition"
echo "[Enter]    - First sector (default)"
echo "+500M      - Size of 500MB"
echo ""
echo "p          - Print partition table"
echo "w          - Write changes and exit"
