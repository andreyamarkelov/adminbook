#!/bin/bash
# Extra Exercise 2: Write a script that generates a simple multiplication table
# for a number provided as an argument. Display the table from 1 to 10.
# Use a for loop with the seq command.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

NUM="$1"

# Validate that the argument is a number
if ! [[ "$NUM" =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$NUM' is not a valid integer."
    exit 1
fi

echo "Multiplication table for $NUM:"
echo "=============================="

for i in $(seq 1 10); do
    RESULT=$((NUM * i))
    printf "%d x %2d = %d\n" "$NUM" "$i" "$RESULT"
done
