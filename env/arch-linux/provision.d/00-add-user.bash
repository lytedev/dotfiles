#!/usr/bin/env bash

u=daniel
ud="/home/$u"

# user exists - we will assume setup has already run
if getent passwd "$u"; then exit 0; fi

groupadd admin 2>/dev/null
mkdir --parents "$ud/.home" "$ud/dl"
useradd --home-dir "$ud/.home" \
	--groups "admin,users" \
	--shell "/bin/bash" \
	"$u"
chown --recursive "$u:$u" "$ud"
echo "Setting password for user '$u'"
passwd "$u"
