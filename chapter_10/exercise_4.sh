#!/bin/bash

# Exercise 4: Use nmcli to display all properties for your primary active connection. 
# Note the ipv4.method value.
#
# Task: Display detailed connection properties.

# Get the active connection name
ACTIVE_CON=$(nmcli -t -f NAME,DEVICE connection show --active | head -n1 | cut -d: -f1)

echo "Displaying properties for: $ACTIVE_CON"
echo ""

nmcli con show "$ACTIVE_CON"
