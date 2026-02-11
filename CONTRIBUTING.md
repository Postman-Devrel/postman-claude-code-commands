# Contributing to Postman Commands & Agents for Claude Code

Thank you for your interest in contributing! This project provides Claude Code commands and agents that bring Postman's API expertise to developers.

## Getting Started

1. Fork and clone the repo
2. Create a branch for your changes
3. Make your changes
4. Test locally
5. Submit a pull request

## Project Structure

```
commands/          # Claude Code slash commands (.md files)
agents/            # Claude Code agents (.md files)
examples/          # Example outputs and reports
install.sh         # Installer script
claude-code/       # Detailed setup guide
```

## How to Test Commands

1. Install commands into a test project:
   ```bash
   ./install.sh /path/to/test-project
   ```

2. Make sure the Postman MCP Server is configured:
   ```bash
   claude mcp add --transport http postman https://mcp.postman.com/mcp \
     --header "Authorization: Bearer YOUR_API_KEY"
   ```

3. Open Claude Code in the test project and run the command (e.g., `/postman help me find APIs`)

4. Verify:
   - The command triggers the correct workflow
   - MCP tools are called appropriately
   - Error handling works (try disconnecting MCP to test fallbacks)
   - Output is clear and actionable

## How to Submit New Commands

### Command File Format

Commands are Markdown files with YAML frontmatter:

```markdown
---
description: Short description shown in the command picker
allowed-tools: Bash, Read, Write, Glob, mcp__postman__*
---

# /command-name — Title

Brief description of what this command does.

## Prerequisites
## Workflow
### Step 1: ...
### Step 2: ...
## Error Handling
```

### Requirements for New Commands

- [ ] Clear description in frontmatter
- [ ] Step-by-step workflow using Postman MCP tools
- [ ] Error handling section covering: MCP not configured, timeout, invalid auth, plan limitations
- [ ] Realistic output examples
- [ ] Added to the commands table in README.md

### Requirements for Agents

- [ ] YAML frontmatter with `name`, `description`, `model`
- [ ] Clear role definition
- [ ] Workflow steps
- [ ] Error handling
- [ ] Added to README.md

## Common MCP Patterns

Commands that use Postman MCP tools should follow these patterns consistently:

**Workspace resolution:** Every command that reads from Postman should start by calling `getWorkspaces` to get the workspace ID. If multiple workspaces exist, ask the user which one to use.

**Collection UIDs:** Some tools (`runCollection`, `createMock`) require collection UIDs in `OWNER_ID-UUID` format. Resolve from `getCollection` or construct from `getAuthenticatedUser`.

**Async operations:** `generateCollection` and `syncCollectionWithSpec` return HTTP 202. Always poll with `getAsyncSpecTaskStatus` before proceeding.

**`syncCollectionWithSpec` limitation:** Only works with OpenAPI 3.0 specs.

**Workspace search:** Use `getCollections` with the `workspace` parameter to search a user's own collections. `searchPostmanElements` only searches the public Postman network.

## Style Guide

- Be direct and practical in command instructions
- Show concrete examples with realistic output
- Always include error handling
- Use Postman MCP tool names exactly (e.g., `getCollections`, `runCollection`)
- Keep prerequisites minimal

## Pull Request Process

1. Ensure your command/agent works end-to-end
2. Update README.md if adding new commands or agents
3. Update CHANGELOG.md with your changes
4. PRs require review from a maintainer

## Code of Conduct

Be respectful, constructive, and collaborative. We're all here to make APIs better for AI agents.

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 License.
