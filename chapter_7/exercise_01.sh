#!/bin/bash

# Exercise 1: Use systemctl to find the default systemd target on your system. 
# Use systemctl to temporarily switch your system to multi-user.target.
#
# Task: Display current default target and switch to multi-user target.

echo "Current default target:"
systemctl get-default

echo ""
echo "Switching to multi-user.target..."
sudo systemctl isolate multi-user.target

echo ""
echo "System is now in multi-user.target mode."
