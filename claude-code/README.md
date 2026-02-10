# Postman for Claude Code

Manage your Postman collections, generate client code from private APIs, and search for available capabilities, all from Claude Code.

Powered by the [Postman MCP Server](https://github.com/postmanlabs/postman-mcp-server).

## Setup

### 1. Get a Postman API Key

Go to [postman.postman.co/settings/me/api-keys](https://postman.postman.co/settings/me/api-keys) and create a key.

### 2. Add the Postman MCP Server

```bash
claude mcp add --transport http postman https://mcp.postman.com/mcp \
  --header "Authorization: Bearer YOUR_API_KEY"
```

This configures the **full** MCP server (100+ Postman tools).

### 3. Install the /postman Command

```bash
# Option A: Copy the command file
mkdir -p .claude/commands
curl -o .claude/commands/postman.md \
  https://raw.githubusercontent.com/Postman-Devrel/postman-ai-integrations/main/claude-code/commands/postman.md

# Option B: Clone and copy
git clone https://github.com/Postman-Devrel/postman-ai-integrations.git
cp postman-ai-integrations/claude-code/commands/postman.md .claude/commands/
```

## What You Can Do

### Sync Collections with Your Code

```
/postman sync my collection with the latest spec
/postman create a collection from my OpenAPI spec
/postman I added 3 new endpoints, update the collection
```

Your Postman collections stay in sync with your codebase. When you change your API, the agent updates the collection, environment, and spec in Postman.

### Generate Client Code from Private APIs

```
/postman generate a TypeScript client for the users API
/postman write a Python wrapper for the payments service
/postman create an SLI for the internal /foo-bar API
```

The agent reads your Postman collection (endpoints, schemas, auth, examples) and generates typed, working client code.

### Search for API Capabilities

```
/postman can I get a user's email via the API?
/postman what endpoints handle payments?
/postman is there an API for sending notifications?
```

Natural language search across all your Postman collections. Get answers, not links.

## Requirements

- [Claude Code](https://claude.ai/claude-code) CLI
- [Postman](https://www.postman.com/) account with API key
- Postman MCP Server (set up in Step 2)

## Related

- [Postman MCP Server](https://github.com/postmanlabs/postman-mcp-server) — The engine powering this integration
- [Postman for Cursor](../cursor/) — Cursor IDE integration with rules and MCP config
- [Postman Plugin](https://github.com/Postman-Devrel/postman-plugin) — Extended Postman plugin for Claude Code (16 capabilities)
