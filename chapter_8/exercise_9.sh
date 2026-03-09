#!/bin/bash

# Exercise 9: Which two lines would you modify in the main OpenSSH server configuration file 
# (/etc/ssh/sshd_config) to disable password authentication and prevent the root user 
# from logging in directly?
#
# Task: Display the SSH configuration changes needed for improved security.

echo "To disable password authentication and prevent root login,"
echo "modify these lines in /etc/ssh/sshd_config:"
echo ""
echo "PasswordAuthentication no"
echo "PermitRootLogin no"
echo ""
echo "After making changes, restart sshd:"
echo "sudo systemctl restart sshd"
