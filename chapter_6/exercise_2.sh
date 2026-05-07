#!/bin/bash

# Exercise 2: Modify the /etc/fstab file to ensure the new XFS partition mounts automatically 
# to /mnt/newxfs every time the system boots. Use the partition's UUID for the entry.
#
# Task: Create mount point, get UUID, and add entry to /etc/fstab.

# Create mount point
sudo mkdir -p /mnt/newxfs

# Get the UUID of the partition
echo "UUID of /dev/sdb1:"
sudo blkid /dev/sdb1

# Add entry to /etc/fstab
# Get the UUID from blkid output and add to fstab
UUID=$(sudo blkid -s UUID -o value /dev/sdb1)
echo "UUID=$UUID /mnt/newxfs xfs defaults 0 0" | sudo tee -a /etc/fstab

# Verify fstab syntax
sudo findmnt --verify

# Reload systemd and mount
sudo systemctl daemon-reload
sudo mount -a

echo "Partition should now be mounted at /mnt/newxfs"
