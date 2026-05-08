#!/bin/bash

# Exercise 7: Generate a new key pair. Use a strong passphrase for security. 
# What are the names of the two files created in your ~/.ssh/ directory?
#
# Task: Generate SSH key pair and identify the created files.

echo "Generating SSH key pair..."
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519

echo ""
echo "Files created in ~/.ssh/:"
ls -la ~/.ssh/id_ed25519*

echo ""
echo "The two files are:"
echo "1. id_ed25519 (private key)"
echo "2. id_ed25519.pub (public key)"
