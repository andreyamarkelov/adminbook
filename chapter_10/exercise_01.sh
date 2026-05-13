#!/bin/bash
# @type: executable
# @requires: none
# @safe: yes
set -euo pipefail

# Exercise 1: Use the ip a command to list all network interfaces. 
# Identify the IP address, netmask (in CIDR format), and MAC address for your primary Ethernet interface.
#
# Task: Display network interface information.

ip addr show
