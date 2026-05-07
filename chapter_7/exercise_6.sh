#!/bin/bash

# Exercise 6: Use renice to change the niceness of a running process, 
# and then confirm the change with ps.
#
# Task: Modify the priority of an already running process.

# First, we need a process to renice
# Start a sleep process in background
sleep 3600 &
PID=$!

echo "Started process with PID: $PID"
echo ""
echo "Original priority:"
ps lax | grep $PID | grep -v grep

# Change the nice value to 15
echo ""
echo "Changing nice value to 15..."
renice -n 15 $PID

# Verify the change
echo ""
echo "New priority:"
ps lax | grep $PID | grep -v grep

echo ""
echo "To kill this process, run: kill $PID"
