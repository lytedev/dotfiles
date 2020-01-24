#!/usr/bin/env bash

dfp=$(cd "$(dirname "${BASH_SOURCE[0]}" )/../../" && pwd)
source "${dfp}/apps/shell/bash/rc"

USER_DISAGREE_CODE=120
NO_AGREEMENT_CODE=121

_dotfiles_setup_check_agreement() {
	local -r lock_file="$1"

	# Let user know that this script will delete their current configuration and
	# that they should read this script before running. We'll use a lock file so
	# the user only needs to agree once.
	if [ -f "$lock_file" ]; then
		# User agreed already - do nothing
		echo -e "\nLinking files...\n"
	else
		echo -e "\nRunning this script may delete existing personal configuration files."
		echo "Please view this script's source, fully understand it, and backup any"
		echo "files before continuing."
		echo -e "\nSeriously. Like... entire directories. Just gone. Completely.\n"
		read -r -p "Are you sure you want to continue? [y/N] " response
		response=${response,,} # to lower case
		if [[ $response =~ ^(yes|y)$ ]]; then
			echo "agreed" > "$lock_file"
		else
			return "${USER_DISAGREE_CODE}"
		fi
	fi
}
export -f _dotfiles_setup_check_agreement

_dotfiles_setup_link_files() {
	local links=("$@")

	source_file=""
	for i in "${links[@]}"; do
		if [ -n "$source_file" ]; then
			if [ -L "$i" ]; then # if symlink exists, delete it
				rm -rf "$i"
			fi
			if [ -f "$i" ]; then # if file exists, delete it
				rm -rf "$i"
			fi
			if [ -d "$i" ]; then # if directory exists, delete it
				rm -rf "$i"
			fi
			# check if the directory that will contain the link exists
			DIR_TO_LINK=$(dirname "$i")
			if [ -d "$DIR_TO_LINK" ]; then
				:
			else
				mkdir -p "$DIR_TO_LINK"
			fi
			ln -s "$source_file" "$i"
			echo -e "  Linking (from/to):\n    ~/$(realpath --relative-to="$HOME" "$source_file")\n    $i"
			source_file=""
		else
			source_file="$i"
		fi
	done
	echo -e "\nDone.\n"
}
export -f _dotfiles_setup_link_files

_dotfiles_setup_run_setup() {
	local -r lock_file="$1" && shift

	if _dotfiles_setup_check_agreement "$lock_file"; then
		_dotfiles_setup_link_files "$@"
	else
		echo "Quitting due to lack of user agreement."
		return "${NO_AGREEMENT_CODE}"
	fi

}
export -f _dotfiles_setup_run_setup
