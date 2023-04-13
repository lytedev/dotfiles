#!/usr/bin/env -S bash -i

u=daniel
ud="/home/$u"

if [[ "$EUID" -ne 0 ]]; then
	echo "Error: This script must be run as root."
	exit 1
fi

# user exists - we will assume setup has already run
if grep -E "^$u" /etc/passwd; then 
	echo "User '$u' already exists. Assuming user has been setup already."
	exit 0
fi

pacman -Sy --needed --noconfirm sudo
echo '%admin ALL=(ALL) ALL' >> /etc/sudoers.d/admin-group-sudoers
groupadd admin 2>/dev/null
mkdir --parents "$ud/.home" "$ud/dl"
useradd --home-dir "$ud/.home" \
	--groups "admin,users,uucp,lock" \
	--shell "/bin/bash" \
	"$u"
chown --recursive "$u:$u" "$ud"
echo "Setting password for user '$u'"
passwd "$u"
