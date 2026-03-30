#!/bin/bash
set -e

COPILOT_CONFIG="$HOME/.copilot/mcp-config.json"
BACKUP="${COPILOT_CONFIG}.bak"

cp "$COPILOT_CONFIG" "$BACKUP"
jq '. + {"autoApprove": true}' "$BACKUP" > "$COPILOT_CONFIG"

trap 'cp "$BACKUP" "$COPILOT_CONFIG"; rm -f "$BACKUP"' EXIT

copilot
