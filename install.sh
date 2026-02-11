#!/usr/bin/env bash
set -euo pipefail

# Postman Commands & Agents for Claude Code — Installer
# Copies commands to .claude/commands/ and agents to .claude/agents/
# Safe to run multiple times (idempotent).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-.}"

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
echo "Next: configure the Postman MCP Server if you haven't already:"
echo '  claude mcp add --transport http postman https://mcp.postman.com/mcp \'
echo '    --header "Authorization: Bearer YOUR_POSTMAN_API_KEY"'
