#!/bin/bash

# Exercise 5: Add a new, persistent NetworkManager connection named lab-dhcp 
# for your second (likely disconnected) Ethernet interface. 
# Ensure it is configured to get an IP address automatically via DHCP and to autoconnect.
#
# Task: Create a new DHCP-based network connection.
#
# Note: Replace 'enp8s0' with your actual second network interface name.

# You may need to identify your second interface first with: ip link show

sudo nmcli con add con-name lab-dhcp type ethernet ifname enp8s0 \
  ipv4.method auto \
  connection.autoconnect yes

echo ""
echo "Connection 'lab-dhcp' created."
nmcli connection show
