#!/bin/bash

# Exercise 4: Delete the devuser2 account, ensuring the home directory is also deleted.
# Verify that the entry is no longer in /etc/passwd.
#
# Task: Remove a user account completely including their home directory.

sudo userdel -r devuser2

# Verify deletion
sudo grep devuser2 /etc/shadow
sudo ls /home
