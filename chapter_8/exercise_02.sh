#!/bin/bash

# Exercise 2: Start a ping 127.0.0.1 process in the foreground. 
# Stop it using the appropriate key sequence, and then send the stopped process 
# to the background so it resumes running.
#
# Task: Demonstrate job control - stopping and backgrounding a process.

echo "Starting ping in foreground..."
echo "Press Ctrl+Z to stop it, then run: bg %1"
echo ""

# Start ping process
ping 127.0.0.1

# After Ctrl+Z is pressed, the user would run:
# jobs
# bg 1
# jobs
