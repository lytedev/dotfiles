#!/usr/bin/env bash

# user's username
USERNAME=daniel
USER_GROUPS="admin,users"

# add admin group
groupadd admin 2>/dev/null

# create actual home directory
mkdir -p "/home/$USERNAME/.home"

# add user with groups
useradd -m -d "/home/$USERNAME/.home" -G "${USER_GROUPS}" -s "/bin/bash" "$USERNAME"

# give home directory ownership
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME"

# have user set new user's password
echo "Setting password for user '$USERNAME'"
passwd "$USERNAME"
