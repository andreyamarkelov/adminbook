#!/bin/bash

# Exercise 3: Schedule a command using at to execute 5 minutes from now. 
# The command should redirect the output of date to a file named ~/test_output.txt.
#
# Task: Schedule a one-time task using the at command.

# Schedule the job
at now + 5 minutes << EOF
date > ~/test_output.txt
EOF

echo "Job scheduled to run in 5 minutes."
echo "The output will be saved to ~/test_output.txt"
