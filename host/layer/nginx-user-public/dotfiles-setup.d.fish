#!/usr/bin/env fish
set me (status -f)
set dfp $argv[1]
set h $argv[2]
set c $argv[3]

pushd (dirname $me)
function force_link
	sudo rm -f "$argv[2]"
	echo "Linking $argv[1] to $argv[2]"
	sudo ln -s "$argv[1]" "$argv[2]"
end

force_link (pwd)/user-public-http.conf /etc/nginx/user-public-http.conf
force_link (pwd)/user-public-server.conf /etc/nginx/user-public-server.conf
force_link (pwd)/.nginx-autoindex-before.html /usr/share/nginx/html/.nginx-autoindex-before.html
force_link (pwd)/.nginx-autoindex-after.html /usr/share/nginx/html/.nginx-autoindex-after.html

echo 'Don\'t forget to include the nginx files in your config inside their respective blocks!'
