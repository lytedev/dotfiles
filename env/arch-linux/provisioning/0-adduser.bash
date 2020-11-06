#!/usr/bin/env bash

USERNAME=daniel
GROUPS="admin,users"

groupadd admin 2>/dev/null
mkdir --parents "/home/$USERNAME/.home"
mkdir --parents "/home/$USERNAME/dl"
useradd --home-dir "/home/$USERNAME/.home" \
	--groups "${GROUPS}" \
	--shell "/bin/bash" \
	"$USERNAME"
chown --recursive "$USERNAME:$USERNAME" "/home/$USERNAME"
echo "Setting password for user '$USERNAME'"
passwd "$USERNAME"
