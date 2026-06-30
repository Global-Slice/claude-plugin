# Slice plugins for Claude Code

Official [Claude Code](https://code.claude.com) plugins published by [Slice Global Equity](https://www.sliceglobal.com).

This repository is a Claude Code [plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces). It currently ships a single plugin:

- [`slice-global`](./plugins/slice-global) — read-only access to your Slice cap table, grants, shares, warrants, convertibles, ownership, equity plans, compliance tickets, workflows, valuations, and company settings through the Slice MCP server.

## What you can ask Claude

Once the plugin is enabled, Claude can answer questions like:

- "Summarize my cap table."
- "List all grants for Alice Smith."
- "What is the fully diluted ownership percentage of our top 5 stakeholders?"
- "Show me all outstanding warrants and their strike prices."
- "How many shares are still available in the 2024 ESOP pool?"
- "What are our highest-risk compliance issues?"
- "Which exercise workflows are waiting on payment or tax withholding?"
- "Model how proceeds would split in a $50M exit waterfall."
- "Prepare a board summary for offered grants and ESOP pool usage."

The plugin is **read-only** in this release: Claude cannot create, modify, or delete data in your Slice account.

## Included guidance

The plugin also ships Claude skills that teach agents how to use Slice MCP tools without over-fetching data:

- Securities and vesting timeline analysis.
- Cap-table, ownership, ESOP pool, share-class, and round analysis.
- Compliance ticket posture and object-level compliance analysis.
- Equity compensation, grant, tax-treatment, valuation, and PTEP analysis.
- Funding round and exit waterfall analysis.
- Workflow, pending payment, and tax-withholding analysis.
- Board presentation and grant approval pack preparation.

Claude Code auto-loads each skill when the user's request matches its frontmatter description. MCP tools themselves are discovered dynamically from the Slice server; run `/mcp slice-global` to inspect the current tool list.

## Prerequisites

- [Claude Code](https://code.claude.com/docs/en/setup) installed.
- An active [Slice](https://www.sliceglobal.com) login at `app.sliceglobal.com`.

## Reviewer / evaluator access

The Slice MCP server is gated behind OAuth against `mcp.app.sliceglobal.com`, which is a paid B2B product. If you are reviewing or evaluating this plugin and do not have a Slice account, email [support@sliceglobal.com](mailto:support@sliceglobal.com) to request a sandbox tenant and test credentials.

## Install

### Claude Code (CLI)

```shell
/plugin marketplace add Global-Slice/claude-plugin
/plugin install slice-global@slice-plugins
```

The first command registers this repository as a marketplace; the second installs the `slice-global` plugin from it.

### claude.ai web

Download the latest release zip and upload it in your Claude settings:

```text
https://github.com/Global-Slice/claude-plugin/releases/latest/download/slice-claude.zip
```

## First-time authentication

The first time Claude calls a Slice tool, Claude Code opens your browser to complete an OAuth 2.1 sign-in against Slice's identity provider (Descope). After you approve, the access and refresh tokens are stored in your operating system's secure store (macOS Keychain, Windows Credential Manager, or libsecret on Linux) and refreshed automatically. Tokens never leave your machine.

## Verify the install

```shell
/plugin list             # slice-global@slice-plugins should be listed and enabled
/mcp                     # the `slice-global` server should appear as connected
/mcp slice-global        # lists every tool the Slice MCP server exposes
```

## Security & privacy

- **Read-only**: this release exposes only read tools. No mutations.
- **Scoped to your login**: every request runs under your Slice user; you only see data your Slice account is authorized to see.
- **No long-lived secrets in the plugin**: `.mcp.json` does not contain any tokens or API keys. All auth is handled by Claude Code's built-in OAuth flow.
- **Tokens stay on your machine**: stored by Claude Code in the OS secure store and refreshed locally.

## Troubleshooting

- **`/mcp slice-global` shows "not connected" or auth errors**: run `/mcp` and reconnect the `slice-global` server. This restarts the OAuth flow and replaces any stale tokens.
- **Browser did not open during sign-in**: copy the URL printed in the Claude Code output and open it manually.
- **Plugin not visible after install**: run `/reload-plugins`, then `/plugin list`.
- **Need to fully reset**: `/plugin uninstall slice-global@slice-plugins` followed by `/plugin install slice-global@slice-plugins`.

If the issue persists, please contact [support@sliceglobal.com](mailto:support@sliceglobal.com).

## License

[MIT](./LICENSE) — © 2026 Slice Global Equity.
