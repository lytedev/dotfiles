#!/usr/bin/env fish

pushd (dirname (status -f))
set dfp $argv[1]
set homedir $argv[2]
set xdgconfdir $argv[3]
set layerdir (pwd)

function _p
	set source $argv[1]
	set dest $argv[2]
	sudo rm -rf "$dest"
	echo "Copying $source to $dest"
	sudo cp -r "$source" "$dest"
end

_p $layerdir/caddy /etc/caddy
_p $layerdir/webserver-root /srv/http
