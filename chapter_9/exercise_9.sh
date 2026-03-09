#!/bin/bash

# Exercise 9: Write the flatpak command to add the Flathub remote repository only 
# for the current user, without system-wide privileges, and only if the remote doesn't already exist.
#
# Task: Add Flathub repository for user-level flatpak installations.

flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Flathub repository added for current user."
