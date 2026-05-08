#!/bin/bash

# Exercise 8: You need to enable key-based authentication for the user root on the local server 127.0.0.1. 
# Use the specialized utility to securely copy your users' public key to the server.
#
# Task: Copy SSH public key to remote server for key-based authentication.

ssh-copy-id -i ~/.ssh/id_ed25519.pub root@127.0.0.1

echo ""
echo "Note: This will work if PermitRootLogin is enabled in the SSH server configuration."
echo "For a separate VM, you may need to modify /etc/ssh/sshd_config:"
echo "  PermitRootLogin yes"
