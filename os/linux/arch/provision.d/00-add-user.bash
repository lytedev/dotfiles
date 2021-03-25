#!/usr/bin/env bash

u=daniel
ud="/home/$u"

# user exists - we will assume setup has already run
if getent passwd "$u"; then exit 0; fi

pacman -S --needed --noconfirm sudo fish git
groupadd admin 2>/dev/null
echo '%admin ALL=(ALL) ALL' >> /etc/sudoers.d/admin-group-sudoers
mkdir --parents "$ud/.home" "$ud/dl"
useradd --home-dir "$ud/.home" \
	--groups "admin,users,uucp,lock" \
	--shell "/bin/bash" \
	"$u"
chown --recursive "$u:$u" "$ud"
chsh --shell /bin/fish
echo "Setting password for user '$u'"

# enforce that a password is set
# we need one for sudo commands in later scripts
while true; do
	passwd "$u"
	ee=$!
	echo $ee
	if [ "$ee" -eq 0 ]; then
		break
	fi
	sleep 2
done
echo $!
