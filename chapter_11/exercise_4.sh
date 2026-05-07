#!/bin/bash

# Exercise 4: Find and enable the SELinux boolean permanently that allows the Apache web server to use NFS.
#
# Task: Enable SELinux boolean for Apache NFS access.

echo "Searching for NFS-related Apache booleans..."
sudo semanage boolean -l | grep nfs | grep http

echo ""
echo "Enabling httpd_use_nfs boolean permanently..."
sudo setsebool -P httpd_use_nfs on

echo ""
echo "Boolean has been enabled."
