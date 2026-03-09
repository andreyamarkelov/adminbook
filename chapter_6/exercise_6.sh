#!/bin/bash

# Exercise 6: Create a 1 Gb file at /tmp/swapfile using dd. 
# Use the mkswap command to format the file as a swap area. 
# Activate the swap file with the swapon command and verify the new total swap size with free -h.
#
# Task: Create and activate a swap file.

# Create 1 GB swap file
sudo dd if=/dev/zero of=/tmp/swapfile bs=1M count=1024

# Set proper permissions (important for security)
sudo chmod 600 /tmp/swapfile

# Format as swap
sudo mkswap /tmp/swapfile

# Activate swap
sudo swapon /tmp/swapfile

# Verify swap is active
free -h

echo ""
echo "Swap file created and activated. Use 'sudo swapoff /tmp/swapfile' to deactivate."
