#!/bin/bash
# @type: executable
# @requires: root
# @safe: no
set -euo pipefail
# Exercise 4: Display a detailed description and list of packages (mandatory, default, and optional) 
# included in the "Legacy UNIX Compatibility" package group.
#
# Task: Show information about a package group.

sudo dnf group info "Legacy UNIX Compatibility"
