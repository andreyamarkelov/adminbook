#!/bin/bash

# Exercise 13: Add the http service to the default zone's runtime configuration. 
# Verify it is listed. Then, reload the firewall using firewall-cmd --reload 
# and verify that the http service is now gone (because it was not permanent).
#
# Task: Demonstrate temporary vs permanent firewall rules.

echo "Adding http service temporarily..."
sudo firewall-cmd --add-service=http

echo ""
echo "Current services (runtime):"
sudo firewall-cmd --list-services

echo ""
echo "Reloading firewall..."
sudo firewall-cmd --reload

echo ""
echo "Services after reload (http should be gone):"
sudo firewall-cmd --list-services
