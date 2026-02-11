# Postman Commands & Agents for Claude Code

Official Postman commands and agents for Claude Code. Analyze APIs, run tests, generate docs, create mocks, and audit security — all from your terminal.

## Quick Start

```bash
# 1. Clone and install commands
git clone https://github.com/Postman-Devrel/postman-claude-code-commands.git
cd postman-claude-code-commands && ./install.sh /path/to/your-project

# 2. Configure the Postman MCP Server
claude mcp add --transport http postman https://mcp.postman.com/mcp \
  --header "Authorization: Bearer YOUR_POSTMAN_API_KEY"

# 3. Use! Open Claude Code and type /postman
```

Get your API key at [postman.postman.co/settings/me/api-keys](https://postman.postman.co/settings/me/api-keys).

Or run `/postman-setup` inside Claude Code for guided configuration.

## Prerequisites

- [Claude Code](https://claude.ai/claude-code) CLI
- [Postman](https://www.postman.com/) account with API key
- Postman MCP Server (configured in Quick Start step 2)

## Commands

| Command | Description | Key MCP Tools |
|---------|-------------|---------------|
| `/postman` | **Swiss army knife** — sync collections, generate clients, search APIs | All Postman MCP tools |
| `/api-test` | Run Postman collection tests, diagnose failures, fix code | `runCollection`, `getCollectionRequest` |
| `/api-docs` | Generate or improve API documentation, publish to Postman | `publishDocumentation`, `syncCollectionWithSpec` |
| `/api-security` | Security audit against OWASP API Top 10 patterns | `getCollection`, `getEnvironment` |
| `/collection-import` | Import OpenAPI spec into a full Postman workspace | `createSpec`, `generateCollection`, `createEnvironment` |
| `/mock-server` | Create mock server for frontend dev and testing | `createMock`, `publishMock` |
| `/postman-setup` | First-run setup — configure MCP, validate API key, verify workspace | — |

### Which command should I use?

```
Do you need to...
├── Do everything / not sure?        → /postman (start here)
├── Set up Postman MCP for first time? → /postman-setup
├── Run API tests?                    → /api-test
├── Generate or publish docs?         → /api-docs
├── Audit for security issues?        → /api-security
├── Import a spec into Postman?       → /collection-import
└── Create a mock server?             → /mock-server
```

**`/postman` is the Swiss army knife.** It handles collection sync, client code generation, and API search. The other commands are specialist shortcuts — they go deeper on one task with more guided workflows.

## API Readiness Analyzer (Agent)

The API Readiness Analyzer agent evaluates your APIs for AI agent compatibility using 48 checks across 8 pillars. It scores your API, diagnoses issues, helps you fix them, and pushes the improved API to Postman.

### What it checks

| Pillar | What It Measures |
|--------|-----------------|
| Metadata | operationIds, summaries, descriptions, tags |
| Errors | Error schemas, codes, messages, retry guidance |
| Introspection | Parameter types, required fields, enums, examples |
| Naming | Consistent casing, RESTful paths, HTTP semantics |
| Predictability | Response schemas, pagination, date formats |
| Documentation | Auth docs, rate limits, external links |
| Performance | Response times, caching, rate limit headers |
| Discoverability | OpenAPI version, server URLs, contact info |

### Usage

```
You: "Is my API agent-ready?"
Agent: Scans spec → Scores 67% → Shows top 5 fixes → Offers to fix them → Pushes to Postman
```

### The full loop

1. Agent analyzes your OpenAPI spec (48 checks, 8 pillars)
2. Claude Code fixes the issues in your spec
3. Postman MCP creates the collection, environment, mock server
4. Postman MCP runs tests to validate
5. Postman MCP publishes documentation

From "broken API" to "fully operational Postman workspace" in one session.

## Install

### One-liner

```bash
git clone https://github.com/Postman-Devrel/postman-claude-code-commands.git && \
  cd postman-claude-code-commands && ./install.sh /path/to/your-project
```

### Manual

```bash
# Commands only
mkdir -p .claude/commands
cp postman-claude-code-commands/commands/*.md .claude/commands/

# Agent
mkdir -p .claude/agents
cp postman-claude-code-commands/agents/*.md .claude/agents/
```

### Single command via curl

```bash
mkdir -p .claude/commands
curl -o .claude/commands/postman.md \
  https://raw.githubusercontent.com/Postman-Devrel/postman-claude-code-commands/main/commands/postman.md
```

## Example Output

See [`examples/sample-readiness-report.md`](examples/sample-readiness-report.md) for a realistic analysis report showing pillar scores, priority fixes, and before/after improvements.

## Compatibility

- **Postman MCP Server:** Tested with v2.x
- **Claude Code:** Requires MCP support (v1.0+)
- **Postman Plans:** Core commands work on all plans. Some features (monitors, team workspaces) may require paid plans.

## Related

- [Postman MCP Server](https://github.com/postmanlabs/postman-mcp-server) — The MCP server powering these commands
- [Postman Plugin for Claude Code](https://github.com/Postman-Devrel/postman-plugin) — Full Postman API lifecycle management plugin

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on testing commands and submitting new ones.

## License

Apache-2.0
