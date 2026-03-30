#!/bin/bash
set -e

CODEX_CONFIG="$HOME/.codex/config.toml"
BACKUP="${CODEX_CONFIG}.bak"

cp "$CODEX_CONFIG" "$BACKUP"

if grep -q 'sandbox_mode' "$CODEX_CONFIG"; then
  sed -i 's/sandbox_mode = ".*"/sandbox_mode = "danger-full-access"/' "$CODEX_CONFIG"
fi
if grep -q 'ask_for_approval' "$CODEX_CONFIG"; then
  sed -i 's/ask_for_approval = ".*"/ask_for_approval = "never"/' "$CODEX_CONFIG"
fi

trap 'cp "$BACKUP" "$CODEX_CONFIG"; rm -f "$BACKUP"' EXIT

codex
