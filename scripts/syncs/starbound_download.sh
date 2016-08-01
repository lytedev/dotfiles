#!/usr/bin/env sh

LOCAL_STORAGE_DIR="$HOME/.local/share/Steam/steamapps/common/Starbound/storage"
REMOTE_STORAGE_HOST_DIR="lytedev.io:~/games/sync/starbound"

mkdir -p "$LOCAL_STORAGE_DIR"

rsync -tr "$REMOTE_STORAGE_HOST_DIR/player" "$LOCAL_STORAGE_DIR"
rsync -tr "$REMOTE_STORAGE_HOST_DIR/universe" "$LOCAL_STORAGE_DIR"
