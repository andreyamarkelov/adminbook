#!/bin/bash

# Exercise 5: Create a directory /tmp/shared_project and a group named devops. 
# Set the directory's group ownership to devops and apply the SGID bit. 
# Add your user to the devops group and verify that any new files you create 
# in that directory inherit the devops group ownership.
#
# Task: Create directory with SGID bit, configure group ownership, and test inheritance.

# Create directory
sudo mkdir -p /tmp/shared_project

# Create group
sudo groupadd devops

# Set group ownership
sudo chgrp devops /tmp/shared_project

# Set permissions with SGID bit (2770)
sudo chmod 2770 /tmp/shared_project

# Add current user to devops group
sudo usermod -aG devops $USER

# Display directory permissions
ls -ld /tmp/shared_project/

# Switch to devops group context
newgrp devops << EOF
# Create a test file
touch /tmp/shared_project/testfile

# Verify group ownership
ls -l /tmp/shared_project/testfile
EOF

echo ""
echo "Verification complete. The testfile should have devops group ownership."
