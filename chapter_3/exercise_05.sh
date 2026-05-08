#!/bin/bash

# Exercise 5: Write a script that lists all executable regular files in the current directory.
#
# Task: Find all files in the current directory that are both regular files and executable,
# then display them with file details.

echo "Executable files in current directory:"

count=0

for file in *; do
    if [ -f "$file" ] && [ -x "$file" ]; then
        ls -lh "$file"
        ((count++))
    fi
done

echo "Total executable files found: $count"

if [ $count -eq 0 ]; then
    echo "No executable files found"
    exit 1
else
    exit 0
fi
