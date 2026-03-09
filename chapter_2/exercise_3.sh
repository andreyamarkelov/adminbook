#!/bin/bash

# Exercise 3: Find in the bash manual page description of aliases and create an alias lls for ls -lah
#
# Task: Search the bash man page for ALIASES section and create a persistent alias
# for the 'ls -lah' command named 'lls'.

# First, view the bash manual for aliases
# man bash
# Type /ALIASES and press Enter to search

# Create the alias in .bashrc
echo "alias lls='ls -lah'" >> ~/.bashrc

# Apply the changes to the current session
source ~/.bashrc

echo "Alias 'lls' has been created for 'ls -lah'"
