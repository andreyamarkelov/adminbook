#!/bin/bash
# Extra Exercise 1: Write a script that takes a filename as an argument
# and displays the number of lines, words, and characters in the file.
# If no argument is provided, print a usage message.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' does not exist or is not a regular file."
    exit 1
fi

LINES=$(wc -l < "$FILE")
WORDS=$(wc -w < "$FILE")
CHARS=$(wc -c < "$FILE")

echo "File: $FILE"
echo "Lines: $LINES"
echo "Words: $WORDS"
echo "Characters: $CHARS"
