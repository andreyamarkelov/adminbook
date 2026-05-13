#!/bin/bash
# @type: executable
# @requires: root
# @safe: no
set -euo pipefail
# Exercise 3: Use nmcli con show to list all available NetworkManager connection profiles. 
# Identify which connections are currently active and on which devices.
#
# Task: List all NetworkManager connections and their status.

nmcli connection show
