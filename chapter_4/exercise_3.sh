#!/bin/bash

# Exercise 3: Lock the devuser2 account. Verify the change by checking entry in /etc/shadow.
#
# Task: Lock a user account and verify the lock status in the shadow file.

sudo usermod -L devuser2

# Verify the lock (should see '!' before the password hash)
sudo grep devuser2 /etc/shadow
