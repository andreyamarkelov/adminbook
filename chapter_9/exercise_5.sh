#!/bin/bash

# Exercise 5: Determine which installed RPM package owns the /etc/filesystems file.
#
# Task: Find the package that provides a specific file.

rpm -qf /etc/filesystems
