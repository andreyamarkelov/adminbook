#!/bin/bash

# Exercise 7: Bring the static1 connection up. 
# Use ip a and ip route to verify that the static IP and new default gateway are active.
#
# Task: Activate a network connection and verify its status.

sudo nmcli con up static1

echo ""
echo "=== IP Address Information ==="
ip a

echo ""
echo "=== Routing Table ==="
ip route
