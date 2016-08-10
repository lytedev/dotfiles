#!/usr/bin/env sh

LOCAL_STORAGE_DIR="$HOME/.local/share/Steam/steamapps/common/Starbound/storage"
REMOTE_STORAGE_HOST_DIR="lytedev.io:~/games/sync/starbound/$(date +%Y.%m.%d_%H.%M.%S)"

rsync -tr "$LOCAL_STORAGE_DIR/player" "$REMOTE_STORAGE_HOST_DIR"
rsync -tr "$LOCAL_STORAGE_DIR/universe" "$REMOTE_STORAGE_HOST_DIR"
