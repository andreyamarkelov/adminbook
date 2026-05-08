#!/bin/bash

# Exercise 1: Execute the sleep 1200 command in the background. 
# Immediately verify it is running, and then note its job number.
#
# Task: Start a background job and verify its status.

# Start sleep in background
sleep 1200 &

echo "Sleep process started in background."
echo ""

# List jobs with PID
jobs -l
