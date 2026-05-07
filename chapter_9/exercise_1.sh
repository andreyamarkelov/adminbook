#!/bin/bash

# Exercise 1: Use DNF to search for packages related to the "network" term, 
# listing only packages that are not yet installed.
#
# Task: Search for available network-related packages.

sudo dnf list available *network*
