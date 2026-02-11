#!/usr/bin/env bash
set -euo pipefail

# Postman Commands & Agents for Claude Code — Installer
# Copies commands to .claude/commands/ and agents to .claude/agents/
# Safe to run multiple times (idempotent).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

POSTMAN_COMMANDS=(
  "postman.md"
  "postman-setup.md"
  "api-test.md"
  "api-docs.md"
  "api-security.md"
  "collection-import.md"
  "mock-server.md"
)
POSTMAN_AGENTS=(
  "postman-agent.md"
)

usage() {
  echo "Usage: ./install.sh [--uninstall] /path/to/your-project"
  echo ""
  echo "  install    Copy Postman commands and agents into your project's .claude/ directory."
  echo "  --uninstall  Remove previously installed Postman commands and agents."
  echo ""
  echo "Run from inside your project? Use: ./install.sh ."
}

if [ $# -eq 0 ]; then
  usage
  exit 1
fi

# Handle --uninstall flag
if [ "$1" = "--uninstall" ]; then
  if [ $# -lt 2 ]; then
    usage
    exit 1
  fi
  TARGET_DIR="$2"
  echo "Removing Postman commands and agents from $TARGET_DIR"
  removed=0
  for f in "${POSTMAN_COMMANDS[@]}"; do
    if [ -f "$TARGET_DIR/.claude/commands/$f" ]; then
      rm "$TARGET_DIR/.claude/commands/$f"
      echo "  ✗ commands/$f"
      removed=$((removed + 1))
    fi
  done
  for f in "${POSTMAN_AGENTS[@]}"; do
    if [ -f "$TARGET_DIR/.claude/agents/$f" ]; then
      rm "$TARGET_DIR/.claude/agents/$f"
      echo "  ✗ agents/$f"
      removed=$((removed + 1))
    fi
  done
  echo ""
  echo "Removed $removed files."
  exit 0
fi

TARGET_DIR="$1"

COMMANDS_SRC="$SCRIPT_DIR/commands"
AGENTS_SRC="$SCRIPT_DIR/agents"
COMMANDS_DST="$TARGET_DIR/.claude/commands"
AGENTS_DST="$TARGET_DIR/.claude/agents"

echo "Installing Postman commands and agents into $TARGET_DIR"

mkdir -p "$COMMANDS_DST" "$AGENTS_DST"

copied=0
for f in "$COMMANDS_SRC"/*.md; do
  [ -f "$f" ] || continue
  cp "$f" "$COMMANDS_DST/"
  echo "  ✓ commands/$(basename "$f")"
  copied=$((copied + 1))
done

for f in "$AGENTS_SRC"/*.md; do
  [ -f "$f" ] || continue
  cp "$f" "$AGENTS_DST/"
  echo "  ✓ agents/$(basename "$f")"
  copied=$((copied + 1))
done

echo ""
echo "Done! Installed $copied files."
echo ""
echo "Next: open Claude Code in your project and run /postman-setup"
echo "It will walk you through API key creation and MCP configuration."
