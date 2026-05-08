#!/bin/bash

# Exercise 4: By using a pipe and a find tool, make a command that will display the number 
# of files in the /etc directory containing "an" in the name.
#
# Task: Use find to search for files with "an" in their names in /etc directory,
# and count them using wc.

find /etc -type f -name "*an*" 2>/dev/null | wc -l
