#!/usr/bin/env fish

pushd (dirname (status -f))
set dfp $argv[1]
set homedir $argv[2]
set xdgconfdir $argv[3]
set layerdir (pwd)

function _ln
	set source $argv[1]
	set dest $argv[2]
	sudo rm -f "$dest"
	echo "Copying $source to $dest"
	sudo ln -s "$source" "$dest"
end

_ln $layerdir/Caddyfile /etc/caddy/Caddyfile
