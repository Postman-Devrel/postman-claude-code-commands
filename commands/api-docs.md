---
description: Generate or improve API documentation and publish to Postman
allowed-tools: Bash, Read, Write, Glob
---

# /api-docs - Generate API Documentation

Generate comprehensive API documentation from your OpenAPI spec or Postman collection. Optionally publish via Postman.

## Prerequisites

Postman MCP Server (full mode) must be configured:
```bash
claude mcp add --transport http postman https://mcp.postman.com/mcp --header "Authorization: Bearer <POSTMAN_API_KEY>"
```

## Workflow

### Step 1: Find the Source

Check for API definitions in this order:

**Local specs:**
- Search for `**/openapi.{json,yaml,yml}`, `**/swagger.{json,yaml,yml}`

**Postman specs:**
- Call `getAllSpecs` to find specs already in Postman
- Call `getSpecDefinition` to pull the full spec

**Postman collections:**
- Call `getCollections` to find relevant collections
- Call `getCollection` to get full collection detail

### Step 2: Analyze Documentation Completeness

Read the spec/collection and assess:

```
Documentation Coverage: 60%
  Endpoints with descriptions:     8/15
  Parameters with descriptions:    22/45
  Endpoints with examples:         3/15
  Error responses documented:      2/15
  Authentication documented:       Yes
  Rate limits documented:          No
```

### Step 3: Generate or Improve

**If spec is sparse:** Generate documentation for each endpoint:
- Operation summary and description
- Parameter table (name, type, required, description)
- Request body schema with examples
- Response schemas with examples for each status code
- Error response documentation
- Authentication requirements per endpoint

**If spec is partial:** Fill the gaps:
- Add missing descriptions (infer from naming and schemas)
- Generate realistic examples from schemas
- Add error responses
- Document authentication and rate limits

### Step 4: Apply Changes

Ask the user which output they want:

1. **Update the spec file** - Write improved docs back into the OpenAPI spec directly
2. **Update in Postman** - Use `updateCollectionRequest` to add descriptions, examples, and documentation to each request in the collection
3. **Publish public docs** - Call `publishDocumentation` to make collection docs publicly accessible. Returns a public URL.
4. **Generate markdown** - Create a `docs/api-reference.md` file for the project

### Step 5: Sync Spec and Collection

If both a spec and collection exist, keep them in sync:
- Call `syncCollectionWithSpec` to update collection from spec changes
- Or call `syncSpecWithCollection` to update spec from collection changes

## Error Handling

- **MCP not configured:** If Postman MCP tools are unavailable, tell the user to run `/postman-setup` or configure manually with `claude mcp add`. You can still generate local markdown docs without MCP.
- **MCP timeout:** Retry the tool call once. If it fails again, suggest checking network connectivity and https://status.postman.com.
- **API key invalid (401):** "Your Postman API key was rejected. Generate a new one at https://postman.postman.co/settings/me/api-keys and reconfigure with `/postman-setup`."
- **Invalid spec:** If the OpenAPI spec has parse errors, report them and ask the user to fix syntax issues first. Offer to help fix common YAML/JSON errors.
- **Too many results:** If `getCollections` returns many collections, ask the user to specify by name rather than listing all.
