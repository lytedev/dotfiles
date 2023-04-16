#!/usr/bin/env -S sh -i

pacman -Sy --noconfirm --needed git fish sudo

echo "## Arch Linux Provisioning ##"

# TODO: use custom meta packages?

is_root="$(test "$(whoami)" == 'root' && echo "1" || echo "0")"
for file in "$(dirname "$0")/provision.d"/*; do
	test -d "$file" && continue
	if echo "$file" | grep -q "AS_ROOT"; then
		if [ "$is_root" = "1" ]; then
			echo "arch/provision.sh: Runnning $file..."
			"$file"
		else
			echo "arch/provision.sh: Runnning sudo $file..."
			sudo "$file"
		fi
	else
		if [ "$is_root" = "1" ]; then
			nf="$(mktemp)"
			cp "$file" "$nf"
			chmod 777 "$nf"
			echo "arch/provision.sh: Runnning sudo -u daniel $file via $nf..."
			sudo -u daniel "$nf"
			rm "$nf"
		else
			echo "arch/provision.sh: Runnning $file..."
			"$file"
		fi
	fi
done
