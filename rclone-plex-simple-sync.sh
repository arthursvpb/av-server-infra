#!/bin/bash

REMOTE_NAME="onedrive:Plex"
LOCAL_DIR="/media/hdd/Plex"
LOG_FILE="./rclone-plex-sync.log"

function log() {
  echo "[$(date)] $1" >>"$LOG_FILE"
}

function safe_sync() {
  SRC="$1"
  DST="$2"
  DIRECTION="$3"

  log "🔍 Dry run: Previewing changes $DIRECTION..."
  echo ""
  rclone sync "$SRC" "$DST" --dry-run --progress
  echo ""
  read -p "⚠️  Are you sure you want to sync $DIRECTION? (yes/no): " CONFIRM
  if [[ "$CONFIRM" == "yes" ]]; then
    log "🚀 Starting real sync $DIRECTION..."
    rclone sync "$SRC" "$DST" \
      --progress \
      --create-empty-src-dirs \
      --log-file "$LOG_FILE" \
      --log-level INFO
    log "✅ Sync $DIRECTION completed."
  else
    log "❌ Sync $DIRECTION aborted by user."
    echo "Aborted."
  fi
}

case "$1" in
to-cloud)
  safe_sync "$LOCAL_DIR" "$REMOTE_NAME" "FROM server TO OneDrive"
  ;;

from-cloud)
  safe_sync "$REMOTE_NAME" "$LOCAL_DIR" "FROM OneDrive TO server"
  ;;

*)
  log "🔄 Safe Bidirectional SYNC: Server <-> OneDrive"
  safe_sync "$LOCAL_DIR" "$REMOTE_NAME" "FROM server TO OneDrive"
  safe_sync "$REMOTE_NAME" "$LOCAL_DIR" "FROM OneDrive TO server"
  log "✅ Safe Bidirectional sync completed."
  ;;
esac
