#!/bin/bash

# Exercise 7: Use tuned-adm active to determine which performance profile is currently active on your system. 
# Switch the active TuneD profile to throughput-performance using the tuned-adm profile command.
#
# Task: Check current TuneD profile and switch to throughput-performance.

echo "Current active TuneD profile:"
tuned-adm active

echo ""
echo "Switching to throughput-performance profile..."
sudo tuned-adm profile throughput-performance

echo ""
echo "New active profile:"
tuned-adm active
