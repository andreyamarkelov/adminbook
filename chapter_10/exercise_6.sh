#!/bin/bash

# Exercise 6: Create a new, persistent connection named static1 for your primary interface. 
# Configure it with the following manual settings:
# IP Address: 192.168.122.55/24
# Gateway: 192.168.122.1
# DNS Server: 8.8.8.8
# Autoconnect: no
#
# Task: Create a static IP network configuration.
#
# Note: Replace 'enp1s0' with your actual primary interface name.

sudo nmcli con add con-name static1 type ethernet ifname enp1s0 \
  ipv4.method manual \
  ipv4.addresses 192.168.122.55/24 \
  ipv4.gateway 192.168.122.1 \
  ipv4.dns 8.8.8.8 \
  connection.autoconnect no

echo ""
echo "Connection 'static1' created successfully."
nmcli connection show
