#!/bin/bash

# Exercise 7: Use the dnf config-manager utility to enable the 
# codeready-builder-for-rhel-10-x86_64-rpms repository.
#
# Task: Enable a DNF repository.

sudo dnf config-manager --enable codeready-builder-for-rhel-10-x86_64-rpms
