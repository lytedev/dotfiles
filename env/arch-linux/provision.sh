#!/usr/bin/env sh
for file in "$(dirname "$0")/provision.d"/*; do "$file"; done
