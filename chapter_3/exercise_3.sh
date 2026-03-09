#!/bin/bash

# Exercise 3: Create a script that creates a directory if it doesn't already exist.
#
# Task: Accept a directory name as an argument and create it if it doesn't exist.
# Handle cases where a file with the same name exists.

if [ $# -eq 0 ]; then
    echo "Error: No directory name provided"
    echo "Usage: $0 directory_name"
    exit 1
fi

dirname="$1"

if [ -d "$dirname" ]; then
    echo "Directory '$dirname' already exists"
    ls -ld "$dirname"
    exit 0
fi

if [ -e "$dirname" ]; then
    echo "Error: '$dirname' exists but is not a directory"
    exit 1
fi

if mkdir -p "$dirname"; then
    echo "Directory '$dirname' created successfully"
    ls -ld "$dirname"
    exit 0
else
    echo "Failed to create directory '$dirname'"
    exit 1
fi
