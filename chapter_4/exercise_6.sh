#!/bin/bash

# Exercise 6: Create a new file /etc/sudoers.d/devs using visudo with option -f. 
# In this new file, add a rule that allows the user devuser2 to run all commands as root 
# without needing a password. Add a rule that allows the group devusers to run all commands 
# defined by alias SERVICES from /etc/sudoers as root that require a password. 
# Make sure SERVICES is uncommented in /etc/sudoers.
# Will devuser2 be required to use a password for /usr/bin/systemctl start?
#
# Task: Configure sudo rules for users and groups with specific permissions.

# Create the sudoers file using visudo
sudo visudo -f /etc/sudoers.d/devs

# Add these lines to the file:
# devuser2 ALL=(ALL) NOPASSWD: ALL
# %devusers ALL=(ALL) SERVICES

# Answer: No, devuser2 will not be required to use a password for /usr/bin/systemctl start
# because devuser2 has NOPASSWD for ALL commands.

echo "After running this script, edit /etc/sudoers.d/devs with:"
echo "devuser2 ALL=(ALL) NOPASSWD: ALL"
echo "%devusers ALL=(ALL) SERVICES"
