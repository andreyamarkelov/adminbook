#!/bin/bash

# Exercise 5: Delete all LVs and VG.
#
# Task: Clean up LVM configuration by removing logical volumes, volume groups, and physical volumes.
#
# WARNING: This will destroy data. Use with caution!

# Remove logical volumes
sudo lvremove /dev/vg01/lv0{1,2}

# Remove volume group
sudo vgremove vg01

# Remove physical volumes
sudo pvremove /dev/sdb{1,5,6,7}

echo "All LVM structures have been removed."
