#!/bin/bash

# Exercise 5: Start a new process with a non-default nice value using the nice command, 
# and then verify the change with ps.
#
# Task: Start a process with modified priority and verify it.

# Start sleep process with nice value of 10
nice -n 10 sleep 3600 &

PID=$!
echo "Started sleep process with PID: $PID and nice value 10"

# Verify the nice value
echo ""
echo "Process information:"
ps lax | grep sleep | grep -v grep
