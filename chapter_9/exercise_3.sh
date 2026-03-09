#!/bin/bash

# Exercise 3: Remove the zsh package and any dependencies that are no longer needed, 
# using a single DNF command.
#
# Task: Uninstall zsh and clean up unused dependencies.

sudo dnf remove -y zsh
