#!/usr/bin/env sh

pacman -Syy

is_root="$(test "$(whoami)" == 'root' && echo "1" || echo "0")"
for file in "$(dirname "$0")/provision.d"/*; do
	test -d "$file" && continue
	echo "Runnning $f..."
	if <<< "$file" grep -q "AS_ROOT"; then
		if [ "$is_root" == "1" ]; then
			"$file"
		else
			sudo "$file"
		fi
	else
		if [ "$is_root" == "1" ]; then
			sudo -u daniel "$file"
		else
			"$file"
		fi
	fi
done
