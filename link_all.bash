#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )/" && pwd)
source "$DIR/variables.bash"

ALERT_AGREEMENT_FILE="$DIR/scripts/agree_to_bootstrap.lock"

# Let user know that this script will delete their current configuration and
# that they should read this script before running. We'll use a lock file so
# the user only needs to agree once.
if [ -f "$ALERT_AGREEMENT_FILE" ]; then
    # User agreed already - do nothing
    echo "Linking..."
else
    echo "Running this script may delete existing personal configuration files."
    echo "Please view this script's source, fully understand it, and backup any files"
    echo "before continuing."
    read -r -p "Are you sure you want to continue? [y/N] " response
    response=${response,,} # to_lower
    if [[ $response =~ ^(yes|y)$ ]]; then
        echo "agreed" > "$ALERT_AGREEMENT_FILE"
    else
        exit 1
    fi
fi

source "$DOTFILES_PATH/colors/link.bash"
source "$DOTFILES_PATH/misc/git/link.bash"
source "$DOTFILES_PATH/editor/nvim/link.bash"
source "$DOTFILES_PATH/env/sh/link.bash"
source "$DOTFILES_PATH/env/x/link.bash"
source "$DOTFILES_PATH/env/wm/link.bash"
