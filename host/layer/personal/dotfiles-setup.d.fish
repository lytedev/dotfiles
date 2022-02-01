#!/usr/bin/env fish
set me (status -f)
set dfp $argv[1]
set h $argv[2]
set c $argv[3]

pushd (dirname $me)
# l app $c/app
