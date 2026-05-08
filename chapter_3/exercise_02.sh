#!/bin/bash

# Exercise 2: Write a script that checks if a file provided as a command-line argument exists.
#
# Task: Accept a filename as an argument and check if it exists as a regular file,
# directory, or doesn't exist at all.

if [ $# -eq 0 ]; then
    echo "Error: No filename provided"
    echo "Usage: $0 filename"
    exit 1
fi

filename="$1"

if [ -f "$filename" ]; then
    echo "File '$filename' exists"
    ls -lh "$filename"
    exit 0
elif [ -d "$filename" ]; then
    echo "'$filename' is a directory, not a regular file"
    exit 2
else
    echo "File '$filename' does not exist"
    exit 1
fi
