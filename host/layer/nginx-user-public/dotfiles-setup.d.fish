#!/usr/bin/env fish
set me (status -f)
set dfp $argv[1]
set h $argv[2]
set c $argv[3]

pushd (dirname $me)
function _cp
	sudo rm -f "$argv[2]"
	echo "Copying $argv[1] to $argv[2]"
	sudo cp "$argv[1]" "$argv[2]"
end

_cp (pwd)/user-public-http.conf /etc/nginx/user-public-http.conf
_cp (pwd)/user-public-server.conf /etc/nginx/user-public-server.conf
_cp (pwd)/.nginx-autoindex-before.html /usr/share/nginx/html/.nginx-autoindex-before.html
_cp (pwd)/.nginx-autoindex-after.html /usr/share/nginx/html/.nginx-autoindex-after.html

echo 'Don\'t forget to include the nginx files in your config inside their respective blocks!'
