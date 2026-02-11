# Troubleshooting

Common issues and how to fix them.

## Commands not found after install

**Symptom:** You run `/postman` and Claude Code says the command doesn't exist.

**Fix:** Restart Claude Code. New commands are loaded on startup, not while a session is running.

```bash
# Verify files were installed
ls .claude/commands/postman.md
ls .claude/agents/postman-agent.md
```

If the files aren't there, re-run the installer:
```bash
./install.sh /path/to/your-project
```

## MCP connection fails or times out

**Symptom:** Commands hang or return "MCP server not responding."

**Possible causes:**
- Network or firewall blocking outbound HTTPS
- Postman services temporarily down
- MCP server not configured

**Fix:**
1. Check if MCP is configured: `claude mcp list | grep postman`
2. Check Postman status: https://status.postman.com
3. Reconfigure: run `/postman-setup` inside Claude Code

## API key rejected (401)

**Symptom:** Commands return "API key was rejected" or 401 errors.

**Possible causes:**
- Key copied with extra whitespace
- Key was revoked or expired
- Key doesn't have workspace access

**Fix:**
1. Generate a new key at https://postman.postman.co/settings/me/api-keys
2. Run `/postman-setup` to reconfigure with the new key

## "Workspace not found" or empty results

**Symptom:** Commands can't find your collections or specs.

**Possible causes:**
- Wrong workspace selected (you may have multiple)
- Collections are in a team workspace but the API key only has personal access

**Fix:**
1. Run `/postman-setup` to verify which workspaces are accessible
2. Check that your collections appear at https://www.postman.com

## Async operations never complete

**Symptom:** `generateCollection` or `syncCollectionWithSpec` seems to hang.

**Possible causes:**
- Large spec taking longer than expected
- Postman backend processing delay

**Fix:**
1. Check the Postman web app to see if the operation completed there
2. For large specs (100+ endpoints), operations may take 30-60 seconds
3. If consistently failing, try breaking the spec into smaller files by domain

## Plan-related errors (403)

**Symptom:** Commands return 403 or "feature not available on your plan."

**Affected features on free plans:**
- Mock server usage limits
- Monitor creation
- Team workspace creation
- Collection run frequency

**Fix:** Check your plan at https://www.postman.com/pricing/. Core commands (import, docs, security audit) work on all plans.

## Still stuck?

File an issue: https://github.com/Postman-Devrel/postman-claude-code-commands/issues
