#!/bin/bash

# Exercise 3: Use parted command to create a new partition with LVM type using 50% of the available space.
# Add partition to existing LVM group and extend / file system.
#
# Task: Create LVM partition, add to volume group, and extend root filesystem.
#
# WARNING: This modifies disk partitions and filesystems. Use with caution!

echo "This script demonstrates the parted and LVM commands needed."
echo ""
echo "Step 1: Create partition with parted"
echo "Run: sudo parted /dev/sdb"
echo "mkpart primary 30% 80%"
echo "set 2 lvm on"
echo "print"
echo "quit"
echo ""
echo "Step 2: Add to LVM"
echo "sudo vgextend rhel /dev/sdb2"
echo ""
echo "Step 3: Extend logical volume and filesystem"
echo "sudo lvextend -l +100%FREE /dev/rhel/root"
echo "sudo xfs_growfs /"
