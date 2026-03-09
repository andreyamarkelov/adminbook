#!/bin/bash

# Exercise 12: Modify the same connection profile to set ipv4.ignore-auto-dns to yes. 
# Reactivate the connection and then inspect the /etc/resolv.conf file 
# to ensure only your manually set DNS servers are present.
#
# Task: Ignore DHCP-provided DNS servers and use only manually configured ones.

# Get the active connection name
ACTIVE_CON=$(nmcli -t -f NAME,DEVICE connection show --active | grep -v '^lo:' | head -n1 | cut -d: -f1)

echo "Modifying connection: $ACTIVE_CON"

sudo nmcli con mod "$ACTIVE_CON" ipv4.ignore-auto-dns yes

sudo nmcli con up "$ACTIVE_CON"

echo ""
echo "Auto-DNS ignored. Contents of /etc/resolv.conf:"
cat /etc/resolv.conf
