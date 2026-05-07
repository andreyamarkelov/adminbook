#!/bin/bash

# Exercise 3: The company wants to run a secondary HTTP server on port 8988. 
# Write the command to permanently label TCP port 8988 as a valid http_port_t port.
#
# Task: Add a custom port to SELinux http_port_t type.

sudo semanage port -a -t http_port_t -p tcp 8988

echo ""
echo "Port 8988 has been added to http_port_t"
echo ""

sudo semanage port -l | grep http_port_t
