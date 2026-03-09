#!/bin/bash

# Exercise 2: You have created a new directory, /srv/www/, which needs to be served by Apache. 
# Write the two commands required to permanently set the context for this directory 
# and all its contents to httpd_sys_content_t.
#
# Task: Set SELinux context for Apache web content directory.

# Add the context rule permanently
sudo semanage fcontext -a -t httpd_sys_content_t "/srv/www(/.*)?"

# Apply the context to the directory
sudo restorecon -Rv /srv/www

echo ""
echo "SELinux context has been set for /srv/www"
