#!/bin/bash

# Exercise 8: Add a second IP address, 10.10.10.55/24, to your active static1 connection. 
# Do not remove the original 192.168.122.55/24 address. 
# Verify with ip a that the interface now has both IP addresses.
#
# Task: Add a secondary IP address to an existing connection.

sudo nmcli con mod static1 +ipv4.addresses 10.10.10.55/24

sudo nmcli con up static1

echo ""
echo "Verifying both IP addresses:"
ip a show enp1s0
