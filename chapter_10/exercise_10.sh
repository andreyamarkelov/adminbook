#!/bin/bash

# Exercise 10: Edit the /etc/hosts file to add a new entry. 
# The entry should map the IP address 192.168.122.55 to the hostnames web55.test.local and web55.
#
# Task: Add a hosts file entry.

echo "192.168.122.55  web55.test.local web55" | sudo tee -a /etc/hosts

echo ""
echo "Entry added to /etc/hosts:"
grep "web55" /etc/hosts
