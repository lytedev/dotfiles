#!/usr/bin/env fish

fd --regex sway-ipc\.$EUID\.\\d+\.sock /var/run/user/$EUID -d 1 --max-results 1

