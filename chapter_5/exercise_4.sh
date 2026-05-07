#!/bin/bash

# Exercise 4: From the vg01 volume group, create a new logical volume named lv01 with a size of 3 GiB.
# Create a second logical volume named lv02 that uses 40% of the remaining free space in the volume group.
#
# Task: Create two logical volumes with different sizing methods.

sudo lvcreate -n lv01 -L 3G vg01

sudo lvcreate -n lv02 -l 40%FREE vg01

# Display the logical volumes
sudo lvdisplay vg01
