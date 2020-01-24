#!/usr/bin/env fish

# TODO: completion
function src-hidden-dir
	not scount $argv && echo "No directory specified" && exit 1
	set f $ENV_PATH/.hidden/fish.d/$argv[1]/config.fish
	echo "Checking $f..."
	test -f $f && source $f
end

set hc $ENV_PATH/.hidden/config.fish
test -f $hc && source $hc

