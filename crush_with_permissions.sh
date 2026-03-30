#!/bin/bash
set -e

CRUSH_CONFIG="$HOME/.config/crush/crush.json"
BACKUP="${CRUSH_CONFIG}.bak"

cp "$CRUSH_CONFIG" "$BACKUP"
jq '. + {"autoApprove": true}' "$BACKUP" > "$CRUSH_CONFIG"

trap 'cp "$BACKUP" "$CRUSH_CONFIG"; rm -f "$BACKUP"' EXIT

crush
