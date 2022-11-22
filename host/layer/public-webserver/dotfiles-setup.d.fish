#!/usr/bin/env fish

pushd (dirname (status -f))
# set dfp $argv[1]
# set homedir $argv[2]
# set xdgconfdir $argv[3]
set layerdir (pwd)

function _p
	echo Copying $argv[1..-2] to $argv[-1]
	sudo cp -r $argv[1..-2] $argv[-1]
end

sudo rm -rf /etc/caddy
_p $layerdir/caddy /etc/caddy

sudo mkdir -p /srv/http
sudo chmod 755 /srv/http
_p $layerdir/webserver-root/* /srv/http
