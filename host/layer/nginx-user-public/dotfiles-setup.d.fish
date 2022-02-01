#!/usr/bin/env fish
set me (status -f)
set dfp $argv[1]
set h $argv[2]
set c $argv[3]

pushd (dirname $me)
sudo ln -s (pwd)/user-public-http.conf /etc/nginx/user-public-http.conf
sudo ln -s (pwd)/user-public-server.conf /etc/nginx/user-public-server.conf
sudo ln -s (pwd)/.nginx-autoindex-before.html /usr/share/nginx/html/.nginx-autoindex-before.html
sudo ln -s (pwd)/.nginx-autoindex-after.html /usr/share/nginx/html/.nginx-autoindex-after.html
