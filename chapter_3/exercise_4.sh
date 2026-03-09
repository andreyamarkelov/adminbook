#!/bin/bash

# Exercise 4: Create a script that performs a numeric countdown from a given starting number to 1.
# If no argument is provided or the argument is not a positive integer, print an error message and exit.
#
# Task: Count down from a specified positive integer to 1, with input validation.

if [ $# -eq 0 ]; then
    echo "Error: No starting number provided"
    echo "Usage: $0 positive_integer"
    exit 1
fi

start="$1"

if ! [[ "$start" =~ ^[0-9]+$ ]]; then
    echo "Error: '$start' is not a valid positive integer"
    exit 1
fi

if [ "$start" -le 0 ]; then
    echo "Error: Number must be greater than 0"
    exit 1
fi

echo "Starting countdown from $start..."
for ((i=start; i>=1; i--)); do
    echo "$i"
done

echo "Countdown complete!"
