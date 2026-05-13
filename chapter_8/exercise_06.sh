#!/bin/bash
# @type: executable
# @requires: none
# @safe: yes
set -euo pipefail

# Exercise 6: Use the Systemd utility to display the current system time, 
# time zone, and the status of the NTP service.
#
# Task: Display time and NTP synchronization status.

timedatectl
