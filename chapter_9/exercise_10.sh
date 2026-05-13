#!/bin/bash
# @type: executable
# @requires: root
# @safe: no
set -euo pipefail

# Exercise 10: Install Gimp from Flathub.
#
# Task: Install the GIMP image editor using flatpak.

flatpak install flathub org.gimp.GIMP

echo "GIMP has been installed via Flatpak."
