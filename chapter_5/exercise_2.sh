#!/bin/bash

# Exercise 2: Convert partitions to LVM type if you used any other. From remaining space create another one.
#
# Task: Change partition types to Linux LVM (type 8e) and create additional partition.
#
# WARNING: This script requires a disk device. Use with caution!

echo "This script demonstrates the fdisk commands needed."
echo "Run: sudo fdisk /dev/sdb"
echo ""
echo "Commands to enter in fdisk:"
echo "t          - Change partition type"
echo "1          - Partition number 1"
echo "8e         - Linux LVM type"
echo ""
echo "t          - Change partition type"
echo "5          - Partition number 5"
echo "8e         - Linux LVM type"
echo ""
echo "t          - Change partition type"
echo "6          - Partition number 6"
echo "8e         - Linux LVM type"
echo ""
echo "n          - Create new partition"
echo "[Enter]    - Accept logical partition"
echo "[Enter]    - First sector (default)"
echo "[Enter]    - Last sector (use remaining space)"
echo ""
echo "t          - Change partition type"
echo "7          - Partition number 7"
echo "8e         - Linux LVM type"
echo ""
echo "p          - Print partition table"
echo "w          - Write changes and exit"
