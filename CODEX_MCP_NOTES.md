# Codex MCP Notes

## Problem

The MCP servers in [`.claude/settings.json`](/workspaces/bus-mgmt-benchmarks-dolt-db/.claude/settings.json) use legacy SSE endpoints:

- `https://bus-mgmt-databases.mcp.mathplosion.com/mcp-dolt-database/sse`
- `https://bus-mgmt-databases.mcp.mathplosion.com/mcp-sec-10ks/sse`
- `https://bus-mgmt-databases.mcp.mathplosion.com/mcp-yfinance-10ks/sse`

Claude can register these directly with `claude mcp add --transport sse`.

Current Codex CLI (`codex-cli 0.117.0`) cannot. Its `codex mcp add --url ...` path expects streamable HTTP, not legacy SSE. Registering the `/sse` URLs directly causes MCP startup failures like:

`UnexpectedContentType(Some("text/plain; charset=utf-8; body: Method Not Allowed"))`

## Fix

Codex now registers these servers through `supergateway` as local stdio MCP servers.

The working command shape is:

```bash
codex mcp add NAME -- npx -y supergateway --sse URL --logLevel none
```

## post-create.sh Change

[`post-create.sh`](/workspaces/bus-mgmt-benchmarks-dolt-db/.devcontainer/post-create.sh) was updated so the Codex section now installs:

```bash
codex mcp add "$name" -- npx -y supergateway --sse "$url" --logLevel none
```

instead of:

```bash
codex mcp add "$name" --url "$url"
```

## Expected Result

After setup, `codex mcp list` should show command-based entries for all three MCPs:

- `dolt`
- `mcp-sec-10ks`
- `mcp-yfinance-10ks`

Example:

```text
dolt               npx -y supergateway --sse https://bus-mgmt-databases.mcp.mathplosion.com/mcp-dolt-database/sse --logLevel none
mcp-sec-10ks       npx -y supergateway --sse https://bus-mgmt-databases.mcp.mathplosion.com/mcp-sec-10ks/sse --logLevel none
mcp-yfinance-10ks  npx -y supergateway --sse https://bus-mgmt-databases.mcp.mathplosion.com/mcp-yfinance-10ks/sse --logLevel none
```

## After Reboot

Run:

```bash
bash .devcontainer/post-create.sh
codex mcp list
```

If the list still shows `Url` entries pointing directly at `/sse`, the old broken registration path is still present somewhere.

If needed, remove and re-add them manually:

```bash
codex mcp remove dolt
codex mcp remove mcp-sec-10ks
codex mcp remove mcp-yfinance-10ks

codex mcp add dolt -- npx -y supergateway --sse https://bus-mgmt-databases.mcp.mathplosion.com/mcp-dolt-database/sse --logLevel none
codex mcp add mcp-sec-10ks -- npx -y supergateway --sse https://bus-mgmt-databases.mcp.mathplosion.com/mcp-sec-10ks/sse --logLevel none
codex mcp add mcp-yfinance-10ks -- npx -y supergateway --sse https://bus-mgmt-databases.mcp.mathplosion.com/mcp-yfinance-10ks/sse --logLevel none
```
