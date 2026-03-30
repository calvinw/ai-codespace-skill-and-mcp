# BusMgmtBenchmarks — Financial Data Codespace

A GitHub Codespace for collecting, verifying, and loading retail company financial data into the [BusMgmtBenchmarks Dolt database](https://www.dolthub.com/repositories/calvinw/BusMgmtBenchmarks).

## What this does

Students and instructors use AI tools to fetch financial statements from SEC 10-K filings and Yahoo Finance, compare them for accuracy, and load verified data into a shared database used for retail management benchmarking.

## AI Tools

All AI tools are pre-installed and pre-configured with MCP server connections:
Claude Code, OpenCode, Gemini CLI, Codex, Copilot, Crush, Pi agent
(from [ai-course-devcontainer](https://github.com/calvinw/ai-course-devcontainer))

## Key Skills

| Command | What it does |
|---------|-------------|
| `/analyze-financials TICKER YEAR` | Fetch, compare, and reconcile financial data from SEC + Yahoo Finance |
| `/insert-financials TICKER YEAR` | Generate SQL to load reconciled data into the database |

Example: `/analyze-financials WMT 2024` → `/insert-financials WMT 2024`

## MCP Servers

| Server | Purpose |
|--------|---------|
| [Dolt MCP](https://bus-mgmt-databases.mcp.mathplosion.com/mcp-dolt-database/sse) | Read/write the BusMgmtBenchmarks database |
| mcp-yfinance-10ks | Fetch financial statements from Yahoo Finance |
| mcp-sec-10ks | Fetch financial statements from SEC 10-K filings |

## Getting started

Open in GitHub Codespaces — all tools and MCP connections are set up automatically by `.devcontainer/post-create.sh`.

## Documentation

- [AGENTS.md](AGENTS.md) — Full technical reference for AI agents: schema, workflows, anomaly rules, gotchas
- [CLAUDE.md](CLAUDE.md) — Claude Code behavior rules, including student communication style
- [Published reports](https://calvinw.github.io/BusMgmtBenchmarks/reports/) — Generated financial analysis reports
