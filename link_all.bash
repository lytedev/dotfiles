#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/" && pwd)
source "$DIR/variables.bash"

# Let user know that this script will delete their current configuration and
# that they should read this script before running. We'll use a lock file so
# the user only needs to agree once.
if [ -f "$DIR/agree_to_bootstrap.lock" ]; then
    # User agreed already - do nothing
    echo "Linking..."
else
    echo "Running this script may delete existing personal configuration files."
    echo "Please view this script's source, fully understand it, and backup any files"
    echo "before continuing."
    read -r -p "Are you sure you want to continue? [y/N] " response
    response=${response,,} # to_lower
    if [[ $response =~ ^(yes|y)$ ]]; then
        touch "$DIR/agree_to_bootstrap.lock"
    else
        exit 1
    fi
fi

source "$DOTFILES_PATH/colors/link.bash"
source "$DOTFILES_PATH/git/link.bash"
source "$DOTFILES_PATH/vim/link.bash"
source "$DOTFILES_PATH/sh/link.bash"
source "$DOTFILES_PATH/x/link.bash"
source "$DOTFILES_PATH/wm/link.bash"
