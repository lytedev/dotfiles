#!/usr/bin/env bash

USERNAME=daniel

groupadd admin 2>/dev/null
mkdir -p "/home/$USERNAME/usr"
useradd -m -d "/home/$USERNAME/usr" -G admin,users,wheel -s "/bin/bash" "$USERNAME"
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME"
echo "Setting password for user '$USERNAME'"
passwd "$USERNAME"
