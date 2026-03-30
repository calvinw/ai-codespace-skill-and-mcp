#!/bin/bash
set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="${WORKSPACE_DIR:-$(cd -- "$SCRIPT_DIR/.." && pwd)}"

cd "$WORKSPACE_DIR"

# Install Bubblewrap in Debian/Ubuntu-based environments when it is missing.
if ! command -v bwrap >/dev/null 2>&1 && command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y bubblewrap
fi

mkdir -p ~/.ssh && ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N '' 2>/dev/null || true
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
