#!/bin/bash

# Exercise 1: Write the two commands necessary to check the SELinux context (label) 
# for both the running sshd process and the /etc/ssh/sshd_config file.
#
# Task: Display SELinux contexts for process and file.

echo "=== SELinux context for sshd process ==="
ps -eZ | grep sshd

echo ""
echo "=== SELinux context for /etc/ssh/sshd_config ==="
ls -Z /etc/ssh/sshd_config
