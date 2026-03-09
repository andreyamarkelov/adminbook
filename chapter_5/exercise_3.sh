#!/bin/bash

# Exercise 3: Using the LVM partitions you created in a previous exercise, 
# create physical volumes and include into vg01 group.
#
# Task: Initialize LVM physical volumes and create a volume group.
#
# WARNING: This will format the specified partitions. Use with caution!

sudo pvcreate /dev/sdb{1,5,6,7}

sudo vgcreate vg01 /dev/sdb{1,5,6,7}

# Display the volume group information
sudo vgdisplay vg01
