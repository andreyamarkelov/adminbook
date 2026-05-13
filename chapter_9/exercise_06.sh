#!/bin/bash
# @type: executable
# @requires: none
# @safe: yes
set -euo pipefail

# Exercise 6: Use the rpm command to list all files included in the installed bash package.
#
# Task: Display all files provided by the bash package.

sudo rpm -ql bash
