#!/bin/bash
# Extra Exercise 3: Write a script that monitors a given log file and
# counts the number of ERROR, WARNING, and INFO lines.
# Accept the log file path as an argument. Use grep -c for counting.

if [ $# -eq 0 ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

LOGFILE="$1"

if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' does not exist."
    exit 1
fi

ERRORS=$(grep -ci "error" "$LOGFILE")
WARNINGS=$(grep -ci "warning" "$LOGFILE")
INFOS=$(grep -ci "info" "$LOGFILE")
TOTAL=$(wc -l < "$LOGFILE")

echo "Log file analysis: $LOGFILE"
echo "=============================="
echo "Total lines:  $TOTAL"
echo "ERROR lines:  $ERRORS"
echo "WARNING lines: $WARNINGS"
echo "INFO lines:   $INFOS"

if [ "$ERRORS" -gt 0 ]; then
    echo ""
    echo "Last 5 ERROR lines:"
    grep -i "error" "$LOGFILE" | tail -5
fi
