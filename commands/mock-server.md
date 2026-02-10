---
description: Create a Postman mock server from your API spec or collection
allowed-tools: Bash, Read, Write, Glob
---

# /mock-server - Create a Mock API Server

Spin up a Postman mock server from your API spec or collection. Get a working mock URL in seconds for frontend development, integration testing, or demos.

## Prerequisites

Postman MCP Server (full mode) must be configured:
```bash
claude mcp add --transport http postman https://mcp.postman.com/mcp --header "Authorization: Bearer <POSTMAN_API_KEY>"
```

## Workflow

### Step 1: Find the Source

**Option A: From existing collection**
- Call `getCollections` to list available collections
- Select the target collection

**Option B: From local spec**
- Find OpenAPI spec in the project
- Import it first using the collection-import workflow:
  1. Call `createSpec` with the spec content
  2. Call `generateCollection` from the spec

### Step 2: Check for Examples

Mock servers serve example responses. Call `getCollection` and check if requests have saved responses with examples.

If examples are missing:
```
Your collection doesn't have response examples. Mock servers
need these to know what to return.

I'll generate realistic examples from your schemas and add them
to the collection.
```

For each request without examples:
1. Call `getCollectionRequest` to get the schema
2. Generate a realistic example response from the schema
3. Call `createCollectionResponse` to add the example

### Step 3: Create Mock Server

Call `createMock` with:
- Collection ID
- Environment ID (if applicable)
- Name: `<api-name> Mock`
- Private: false (or true if user prefers)

### Step 4: Present Mock URL

```
Mock server created: "Pet Store API Mock"
  URL: https://<mock-id>.mock.pstmn.io
  Status: Active

  Try it:
    curl https://<mock-id>.mock.pstmn.io/pets
    curl https://<mock-id>.mock.pstmn.io/pets/1
    curl -X POST https://<mock-id>.mock.pstmn.io/pets -d '{"name":"Buddy"}'

  The mock serves the example responses from your collection.
  Update examples in Postman to change mock behavior.
```

### Step 5: Integration

```
Quick integration:
  # Add to your project .env
  API_BASE_URL=https://<mock-id>.mock.pstmn.io

  # Or configure in your frontend
  const API_URL = process.env.API_BASE_URL || 'https://<mock-id>.mock.pstmn.io';
```

### Step 6: Publish (optional)

If the user wants the mock publicly accessible:
- Call `publishMock` to make it available without authentication
- Useful for demos, hackathons, or public documentation

To make it private again:
- Call `unpublishMock`
