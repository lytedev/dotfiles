#!/usr/bin/env bash

dir="$(dirname "$(realpath "$0")")"
echo "Inside $dir"

yn() {
	echo "$1 [y/N]"
	read -r y
	# bash convert to lowercase magic
	[[ ${y,,} =~ ^y ]]
}

yn "Do you want to install UI packages?" && "$dir/optional/ui-packages.bash"
