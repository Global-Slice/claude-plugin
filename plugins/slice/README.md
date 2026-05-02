# `slice` plugin

Read-only access to your [Slice](https://www.sliceglobal.com) cap-table, grants, shares, warrants, convertibles, ownership, equity plans, compliance tickets, workflows, valuations, and company settings for [Claude Code](https://code.claude.com), powered by the Slice MCP server.

## Install

```shell
/plugin marketplace add Global-Slice/claude-plugin
/plugin install slice@slice-plugins
```


## Capabilities

The Slice MCP server exposes read-only tools for cap-table, securities, ownership, stakeholders, share classes, rounds, ESOP pools, compliance tickets, workflows, payments, tax withholding, valuations, and related company configuration. Run `/mcp slice` to see the current tool list.

This plugin also includes Claude skills for using those tools effectively:

- `securities-analysis`
- `cap-table-analysis`
- `compliance-analysis`
- `equity-compensation-analysis`
- `funding-rounds-analysis`
- `waterfall-analysis`
- `workflows-analysis`
- `board-presentation-analysis`

The skills favor aggregate/filter-first workflows and avoid dumping large raw records into the chat context.

## First-time authentication

The first time Claude calls a Slice tool, Claude Code opens your browser to complete an OAuth 2.1 sign-in against Slice's identity provider (Descope). Tokens are stored in your operating system's secure store (macOS Keychain, Windows Credential Manager, or libsecret on Linux) and refreshed automatically — they never leave your machine.

## Verify

```shell
/mcp                  # the `slice` server should appear as connected
/mcp slice            # lists every tool the Slice MCP server exposes
```

## Security & privacy

- **Read-only**: this release exposes only read tools. No mutations.
- **Scoped to your login**: every request runs under your Slice user; you only see data your Slice account is authorized to see.
- **No secrets in the plugin**: `.mcp.json` contains only the server URL. Auth is handled by Claude Code's built-in OAuth flow.

## Troubleshooting

If `/mcp slice` shows auth errors, run `/mcp` and reconnect the `slice` server to restart the OAuth flow and replace any stale tokens.

For more details, see the [marketplace README](../../README.md). For help, contact [support@sliceglobal.com](mailto:support@sliceglobal.com).
