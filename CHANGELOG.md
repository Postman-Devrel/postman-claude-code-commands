# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] — 2026-02-11

### Added
- `/postman` — Swiss army knife command for collection management, code generation, and API search
- `/api-test` — Run Postman collection tests and diagnose failures
- `/api-docs` — Generate or improve API documentation
- `/api-security` — Security audit against OWASP API Top 10
- `/collection-import` — Import OpenAPI specs into a full Postman workspace
- `/mock-server` — Create Postman mock servers
- `/postman-setup` — First-run configuration wizard
- **API Readiness Analyzer** agent — 48-check, 8-pillar API agent-readiness analysis
- `install.sh` — One-command installer for commands and agents
- Error handling in all commands (MCP not configured, timeouts, auth errors, plan limits)
- CONTRIBUTING.md
- GitHub Actions for markdown linting and link checking
- Example readiness analysis report

### Compatibility
- Tested with Postman MCP Server v2.x
- Requires Claude Code CLI with MCP support
