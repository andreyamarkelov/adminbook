#!/bin/bash

# Exercise 11: Modify your active connection profile to use the static DNS servers 8.8.8.8 and 8.8.4.4
#
# Task: Configure custom DNS servers for a network connection.

# Get the active connection name
ACTIVE_CON=$(nmcli -t -f NAME,DEVICE connection show --active | grep -v '^lo:' | head -n1 | cut -d: -f1)

echo "Modifying connection: $ACTIVE_CON"

sudo nmcli con mod "$ACTIVE_CON" ipv4.dns "8.8.8.8 8.8.4.4"

sudo nmcli con up "$ACTIVE_CON"

echo ""
echo "DNS servers configured. Contents of /etc/resolv.conf:"
cat /etc/resolv.conf
