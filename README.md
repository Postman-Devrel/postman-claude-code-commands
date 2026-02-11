# Postman Commands & Agents for Claude Code

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Postman MCP](https://img.shields.io/badge/Postman-MCP%20Server-orange)](https://github.com/postmanlabs/postman-mcp-server)

Slash commands and agents that connect [Claude Code](https://docs.anthropic.com/en/docs/claude-code) to the [Postman MCP Server](https://github.com/postmanlabs/postman-mcp-server). Analyze APIs, run tests, generate docs, create mocks, and audit security from your terminal.

> **What's MCP?** [Model Context Protocol](https://modelcontextprotocol.io/) lets AI tools like Claude Code call external services directly. The Postman MCP Server gives Claude Code access to your Postman workspaces, collections, and APIs.

## Quick Start

```bash
# 1. Clone the repo (anywhere — it's not part of your project)
git clone https://github.com/Postman-Devrel/postman-claude-code-commands.git

# 2. Install commands into your project
cd postman-claude-code-commands && ./install.sh /path/to/your-project

# 3. Open Claude Code in your project and run guided setup
/postman-setup
```

That's it. `/postman-setup` walks you through API key creation, MCP configuration, and workspace verification.

<details>
<summary>Manual MCP setup (if you prefer)</summary>

```bash
claude mcp add --transport http postman https://mcp.postman.com/mcp \
  --header "Authorization: Bearer YOUR_POSTMAN_API_KEY"
```

Get your API key at [postman.postman.co/settings/me/api-keys](https://postman.postman.co/settings/me/api-keys).

</details>

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) v1.0+ (requires MCP support)
- [Postman account](https://identity.getpostman.com/signup) (free plan works for most commands, no desktop app required)

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

**`/postman` is the Swiss army knife.** It handles collection sync, client code generation, and API search. The other commands are specialist shortcuts with more guided workflows and better error handling for their specific task.

**`/postman` vs `/collection-import`:** Both can import specs. Use `/collection-import` when you want the full guided flow (spec + collection + environment + next steps). Use `/postman` when importing is one step in a larger task.

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

> **Note:** This installs only `/postman`. For the full set (including `/postman-setup`), use the installer above.

```bash
mkdir -p .claude/commands
curl -o .claude/commands/postman.md \
  https://raw.githubusercontent.com/Postman-Devrel/postman-claude-code-commands/main/commands/postman.md
```

### Uninstall

```bash
./install.sh --uninstall /path/to/your-project
```

This removes only the Postman command and agent files. Your other `.claude/` files are untouched.

## Example Output

See [`examples/sample-readiness-report.md`](examples/sample-readiness-report.md) for a realistic analysis report showing pillar scores, priority fixes, and before/after improvements.

## Commands vs Plugin vs Raw MCP

| | Commands (this repo) | [Postman Plugin](https://github.com/Postman-Devrel/postman-plugin) | Raw MCP |
|---|---|---|---|
| Setup | One script | npm install | Manual `claude mcp add` |
| Scope | Per-project | Global | Global |
| Customization | Edit markdown files | Limited | Full control |
| Learning curve | Low | Medium | High |
| Best for | Task-specific workflows | Full API lifecycle | Power users |

**Start here.** These commands give you guided workflows for common tasks. Upgrade to the plugin if you need advanced features.

## Related

- [Postman MCP Server](https://github.com/postmanlabs/postman-mcp-server) — The MCP server powering these commands
- [Postman Plugin for Claude Code](https://github.com/Postman-Devrel/postman-plugin) — Full Postman API lifecycle management plugin

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues (commands not found, MCP connection failures, auth errors, plan limits).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on testing commands and submitting new ones.

## License

Apache-2.0
