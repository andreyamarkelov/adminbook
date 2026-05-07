#!/bin/bash

# Exercise 1: Create a new devusers group. Create new users named devuser1, devuser2, and devuser3,
# and add them to the devusers group. Add devuser1 to the wheel group.
#
# Task: Set up a new group and three users with proper group memberships.

sudo groupadd devusers
sudo useradd -G devusers devuser1
sudo useradd -G devusers devuser2
sudo useradd -G devusers devuser3
sudo usermod -aG wheel devuser1

# Set passwords for the users
echo "Password for user devuser1"
sudo passwd devuser1
echo "Password for user devuser2"
sudo passwd devuser2
echo "Password for user devuser3"
sudo passwd devuser3

# Verify user configurations
id devuser1
id devuser2
id devuser3

# Verify group memberships
getent group wheel
getent group devusers
