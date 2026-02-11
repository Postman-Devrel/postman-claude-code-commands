---
description: Import an OpenAPI spec into Postman as a fully configured workspace
allowed-tools: Bash, Read, Write, Glob
---

# /collection-import - Import API Spec to Postman

Import your OpenAPI spec into Postman and set up a complete workspace: collection, environment, and optionally a mock server and monitor.

## Prerequisites

Postman MCP Server (full mode) must be configured:
```bash
claude mcp add --transport http postman https://mcp.postman.com/mcp --header "Authorization: Bearer <POSTMAN_API_KEY>"
```

## Workflow

### Step 1: Find the Spec

Look for OpenAPI specs in the project:
- `**/openapi.{json,yaml,yml}`
- `**/swagger.{json,yaml,yml}`
- `**/*-api.{json,yaml,yml}`

If the user provides a URL, fetch the spec.

### Step 2: Create Workspace (optional)

If the user wants a dedicated workspace:
- Call `createWorkspace` with name derived from the API title
- Use type "personal" by default, or "team" if they specify

### Step 3: Create Spec in Postman

- Call `createSpec` with the spec name, description, and content
- This stores the OpenAPI definition in Postman's Spec Hub

### Step 4: Generate Collection

- Call `generateCollection` from the spec
- This auto-creates a collection with:
  - Requests for every endpoint
  - Request bodies from schema examples
  - Organized by tags/folders

### Step 5: Create Environment

Extract variables from the spec and create an environment:

Call `createEnvironment` with variables:
- `base_url` - from spec's server URL
- `api_key` - empty, marked as secret (if spec uses API key auth)
- `auth_token` - empty, marked as secret (if spec uses Bearer auth)
- Any path parameters used across multiple endpoints

### Step 6: Confirm and Suggest Next Steps

```
Workspace set up: "Pet Store API"
  Spec:         Pet Store API v3.0 (in Spec Hub)
  Collection:   15 requests, organized by tag
  Environment:  Development (base_url, api_key)

  Next steps:
  - /api-test    → Run the collection tests
  - /mock-server → Create a mock for frontend development
  - /api-docs    → Publish documentation
```

## Error Handling

- **MCP not configured:** This command requires MCP. Tell the user to run `/postman-setup`.
- **MCP timeout:** Retry once. If `createSpec` or `generateCollection` times out, the spec may be too large. Suggest breaking it into smaller specs by domain.
- **API key invalid (401):** "Your Postman API key was rejected. Generate a new one at https://postman.postman.co/settings/me/api-keys"
- **Invalid spec:** If the spec has parse errors (invalid YAML/JSON, missing required OpenAPI fields), report the specific errors. Offer to fix common issues like missing `info` or `paths` fields.
- **Plan limitations:** Workspace creation may be limited on free plans. If `createWorkspace` fails, use the default "My Workspace" instead.
