#!/bin/bash
set -e

mkdir -p ~/.ssh && ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N '' 2>/dev/null || true
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# ─── skillshare ───────────────────────────────────────────────────────────────
curl -fsSL https://raw.githubusercontent.com/runkids/skillshare/main/install.sh | sh
skillshare sync

# ─── MCP Servers ──────────────────────────────────────────────────────────────
# MCP configs are now checked in to the repo:
# - .copilot/mcp-config.json (GitHub Copilot CLI)
# - .opencode/opencode.json (OpenCode)
# - .gemini/settings.json (Gemini CLI)
# - .config/crush/crush.json (Crush)
# Tools will auto-discover these from the project directory.

# Optional: Link to user home directories for tools that don't auto-discover
WORKSPACE_DIR="${WORKSPACE_DIR:-$(pwd)}"
mkdir -p ~/.copilot ~/.config/opencode ~/.gemini ~/.config/crush
ln -sf "$WORKSPACE_DIR/.copilot/mcp-config.json" ~/.copilot/mcp-config.json 2>/dev/null || true
ln -sf "$WORKSPACE_DIR/.opencode/opencode.json" ~/.config/opencode/opencode.json 2>/dev/null || true
ln -sf "$WORKSPACE_DIR/.gemini/settings.json" ~/.gemini/settings.json 2>/dev/null || true
ln -sf "$WORKSPACE_DIR/.config/crush/crush.json" ~/.config/crush/crush.json 2>/dev/null || true
