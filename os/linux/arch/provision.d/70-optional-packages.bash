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

paru -Sy --needed --noconfirm \
	weechat `# IRC Client` \
	rtx-bin `# Version Manager` \
	bluetuith-bin `# Disk Usage Analyzer` \
	aria2 `# Downloads Manager` \
	oath-toolkit `# TOTP Utility` \
	pass pass-otp `# Password Management` \
	sc-im `# Spreadsheets` \
	cloc `# For counting lines of code` \
	gitui `# Git TUI` \
	tokei `# Counting Lines of Code (cloc alternative)` \
	pigz `# Multicore Compression Utility` \
