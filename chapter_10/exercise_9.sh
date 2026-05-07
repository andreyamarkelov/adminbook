#!/bin/bash

# Exercise 9: Change your system's persistent hostname to server15.test.local.
#
# Task: Set a new system hostname.

sudo hostnamectl set-hostname server15.test.local

echo "Hostname changed to server15.test.local"
echo "Please re-open your shell session to see the change."
echo ""
echo "Current hostname:"
hostnamectl
