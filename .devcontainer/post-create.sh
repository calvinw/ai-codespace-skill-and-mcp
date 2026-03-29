#!/bin/bash
set -e

mkdir -p ~/.ssh && ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N '' 2>/dev/null || true
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# ─── skillshare ───────────────────────────────────────────────────────────────
curl -fsSL https://raw.githubusercontent.com/runkids/skillshare/main/install.sh | sh
skillshare sync

# ─── MCP Servers ──────────────────────────────────────────────────────────────
# MCP configs are checked in to the repo:
# - .claude/settings.json       (Claude Code — registered via 'claude mcp add' below)
# - .copilot/mcp-config.json    (GitHub Copilot CLI)
# - .opencode/opencode.json     (OpenCode)
# - .gemini/settings.json       (Gemini CLI)
# - .crush.json                 (Crush)
#
# Symlinks below make configs available globally (e.g. when running a tool
# outside the project directory).
WORKSPACE_DIR="${WORKSPACE_DIR:-$(pwd)}"
mkdir -p ~/.copilot ~/.config/opencode ~/.gemini ~/.config/crush
ln -sf "$WORKSPACE_DIR/.copilot/mcp-config.json" ~/.copilot/mcp-config.json 2>/dev/null || true
ln -sf "$WORKSPACE_DIR/.opencode/opencode.json" ~/.config/opencode/opencode.json 2>/dev/null || true
ln -sf "$WORKSPACE_DIR/.gemini/settings.json" ~/.gemini/settings.json 2>/dev/null || true
ln -sf "$WORKSPACE_DIR/.crush.json" ~/.config/crush/crush.json 2>/dev/null || true

# Register Claude Code MCP servers from .claude/settings.json into ~/.claude.json
if command -v jq >/dev/null 2>&1 && command -v claude >/dev/null 2>&1; then
  SETTINGS="$WORKSPACE_DIR/.claude/settings.json"
  if [ -f "$SETTINGS" ]; then
    jq -r '.mcpServers | to_entries[] | "\(.key) \(.value.url)"' "$SETTINGS" | \
    while IFS=' ' read -r name url; do
      claude mcp add -s user "$name" --transport sse "$url" 2>/dev/null || true
    done
  fi
fi
