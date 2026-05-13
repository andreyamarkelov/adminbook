#!/bin/bash
# @type: executable
# @requires: root
# @safe: yes
set -euo pipefail

# Exercise 3: Examine the output of journalctl -b to review the messages from the most recent system boot.
#
# Task: Display system journal entries from the current boot.

sudo journalctl -b
