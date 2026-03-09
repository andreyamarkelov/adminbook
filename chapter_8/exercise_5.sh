#!/bin/bash

# Exercise 5: Edit your user's crontab file to run the command 
# /bin/echo "Cron!" > ~/cron.log every day at 9:00.
#
# Task: Create a cron job that runs daily at 9 AM.

echo "Adding cron job..."

# Add the cron job
(crontab -l 2>/dev/null; echo "0 9 * * * /bin/echo \"Cron!\" > ~/cron.log") | crontab -

echo ""
echo "Current crontab:"
crontab -l
