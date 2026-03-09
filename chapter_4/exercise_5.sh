#!/bin/bash

# Exercise 5: For devuser1, set the minimum number of days between password changes to 8 and 
# the maximum number of days to 40. Set the warning period before devuser1's password expires 
# to 14 days. Force devuser1 to change their password on the next login. 
# Set the devuser1's account to expire on December 30, 2028.
#
# Task: Configure password aging and account expiration settings for a user.

sudo chage -m 8 -M 40 -W 14 -d 0 -E 2028-12-31 devuser1

# Verify the settings
sudo chage -l devuser1
