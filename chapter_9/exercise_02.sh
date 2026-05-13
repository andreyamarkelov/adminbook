#!/bin/bash
# @type: executable
# @requires: root
# @safe: no
set -euo pipefail
# Exercise 2: Install the zsh package using DNF, ensuring the installation proceeds 
# without any interactive prompts.
#
# Task: Install zsh package non-interactively.

sudo dnf install -y zsh
