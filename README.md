# Postman Commands & Agents for Claude Code

Official Postman commands and agents for Claude Code. Analyze APIs, run tests, generate docs, create mocks, and audit security, all from your terminal.

## Prerequisites

### Postman MCP Server (Required for commands)

All commands use the Postman MCP Server (full mode). Install it once:

```bash
claude mcp add --transport http postman https://mcp.postman.com/mcp --header "Authorization: Bearer YOUR_POSTMAN_API_KEY"
```

Get your API key at [postman.postman.co/settings/me/api-keys](https://postman.postman.co/settings/me/api-keys)

### Clara CLI (Required for the Postman Agent)

The Postman Agent uses Clara for API readiness analysis:

```bash
npm install -g @sterlingchin/clara
```

Or use npx (no install needed, slower first run).

## Install

### Commands

Copy individual commands into your project's `.claude/commands/` directory:

```bash
# All commands
git clone https://github.com/Postman-Devrel/postman-claude-code-commands.git
cp postman-claude-code-commands/commands/*.md .claude/commands/

# Or just one command
curl -o .claude/commands/api-test.md https://raw.githubusercontent.com/Postman-Devrel/postman-claude-code-commands/main/commands/api-test.md
```

### Postman Agent

Copy the agent into your project's `.claude/agents/` directory:

```bash
mkdir -p .claude/agents
cp postman-claude-code-commands/agents/postman-agent.md .claude/agents/
```

## Commands

| Command | Description | Key MCP Tools |
|---------|-------------|---------------|
| `/api-test` | Run Postman collection tests, diagnose failures, fix code | `runCollection`, `getCollectionRequest` |
| `/api-docs` | Generate or improve API documentation, publish to Postman | `publishDocumentation`, `syncCollectionWithSpec` |
| `/api-security` | Security audit against OWASP API Top 10 patterns | `getCollection`, `getEnvironment` |
| `/collection-import` | Import OpenAPI spec into a full Postman workspace | `createSpec`, `generateCollection`, `createEnvironment` |
| `/mock-server` | Create mock server for frontend dev and testing | `createMock`, `publishMock` |

## Postman Agent (Codename: Clara)

The Postman Agent analyzes your APIs for AI agent compatibility using Clara's 8-pillar framework (48 checks). It scores your API, diagnoses issues, helps you fix them, and pushes the improved API to Postman.

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

1. Clara analyzes your OpenAPI spec (48 checks, 8 pillars)
2. Claude Code fixes the issues in your spec
3. Postman MCP creates the collection, environment, mock server
4. Postman MCP runs tests to validate
5. Postman MCP publishes documentation

From "broken API" to "fully operational Postman workspace" in one session.

## Example Output

See [`examples/sample-clara-report.md`](examples/sample-clara-report.md) for a realistic Clara analysis report showing pillar scores, priority fixes, and before/after improvements.

## Related

- [Postman Plugin for Claude Code](https://github.com/Postman-Devrel/postman-plugin) - Full Postman API lifecycle management plugin
- [Postman MCP Server](https://github.com/postmanlabs/postman-mcp-server) - The MCP server powering these commands
- [Clara](https://github.com/Postman-Devrel/clara) - API agent-readiness analyzer
- [Postman Cursor Rules](https://github.com/Postman-Devrel/postman-cursor-rules) - Cursor IDE integration

## License

Apache-2.0
