#!/usr/bin/env bash

groupadd admin 2>/dev/null
mkdir -p /home/daniel
useradd -m -d /home/daniel/usr -G admin,users -s /usr/bin/bash daniel
chown -R daniel:daniel /home/daniel
echo "Setting password for user 'daniel'"
passwd daniel
