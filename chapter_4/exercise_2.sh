#!/bin/bash

# Exercise 2: Modify the devuser3 account. Change the comment field to "Senior Developer - devuser3",
# add him to an existing secondary group named sshd, and change their default shell to /usr/sbin/nologin.
# Ensure that existing secondary groups are preserved.
#
# Task: Modify user attributes including comment, shell, and group membership.

sudo usermod -c "Senior Developer - devuser3" -aG sshd -s /usr/sbin/nologin devuser3

# Verify the changes
getent passwd devuser3
id devuser3
