#!/bin/bash

# Exercise 14: Permanently add TCP port 8080 to the public zone. 
# Reload the firewall and verify that the port is now active in the runtime configuration.
#
# Task: Add a permanent firewall rule for a custom port.

sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent

echo "Port 8080/tcp added permanently."
echo ""

echo "Reloading firewall..."
sudo firewall-cmd --reload

echo ""
echo "Open ports in public zone:"
sudo firewall-cmd --zone=public --list-ports
