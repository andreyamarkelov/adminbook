#!/bin/bash

# Exercise 1: Create a script that takes two numbers as command-line arguments and prints their sum.
#
# Task: Accept two numeric arguments, validate them, and calculate their sum.

if [ $# -ne 2 ]; then
    echo "Error: Two numbers required"
    echo "Usage: $0 number1 number2"
    exit 1
fi

if ! [[ "$1" =~ ^-?[0-9]+$ ]] || ! [[ "$2" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Both arguments must be numbers"
    exit 1
fi

sum=$(( $1 + $2 ))
echo "Sum of $1 and $2 is: $sum"
