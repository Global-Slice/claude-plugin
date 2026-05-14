# AGENTS.md

Contributor guide for AI agents working on the Slice Claude plugin marketplace.

## Repository layout

```text
claude-plugin/
├── .claude-plugin/marketplace.json   # Marketplace manifest (lists all plugins)
├── .github/
│   ├── workflows/
│   │   ├── validate_plugin.yml       # PR: claude plugin validate + version sync
│   │   ├── release.yml               # Tag push: build zip + GitHub Release
│   │   └── auto-tag.yml              # Main push: auto-tag on version bump
│   └── dependabot.yml                # GitHub Actions updates
├── scripts/
│   ├── build-release-claude.sh       # Stage plugins/slice/ → dist/slice-claude-<v>.zip
│   └── validate-versions.sh          # Keep marketplace.json + plugin.json in sync
├── plugins/slice/                    # The slice plugin
│   ├── .claude-plugin/plugin.json    # Plugin manifest (canonical version source)
│   ├── .mcp.json                     # MCP server config (Slice HTTP endpoint)
│   ├── assets/logo.png               # Plugin branding
│   ├── hooks/                        # PreToolUse hooks for skill injection
│   │   ├── hooks.json
│   │   └── guide-*.sh
│   └── skills/                       # Claude skills (one folder per skill)
├── AGENTS.md                         # This file
├── CHANGELOG.md                      # Keep-a-Changelog format
├── LICENSE                           # MIT
└── README.md                         # Install instructions + permanent zip URL
```

## Version-bump checklist

The canonical version lives in `plugins/slice/.claude-plugin/plugin.json`. When bumping:

1. Update `version` in `plugins/slice/.claude-plugin/plugin.json` (source of truth).
2. Update `metadata.version` and the `slice` plugin entry `version` in `.claude-plugin/marketplace.json`.
3. Add a new dated entry to `CHANGELOG.md`.
4. Merge to `main` — the `auto-tag.yml` workflow creates the git tag automatically.

Run `bash scripts/validate-versions.sh` locally to verify all version fields match before pushing.

## Adding a new skill

1. Create `plugins/slice/skills/<skill-name>/SKILL.md`.
2. If the skill covers a new MCP tool domain, add a `PreToolUse` matcher entry in `plugins/slice/hooks/hooks.json` and a corresponding `guide-<domain>.sh` script in `plugins/slice/hooks/`.
3. Update the skill list in `plugins/slice/README.md` and the root `README.md`.

## Skill conventions

- Each skill is a single `SKILL.md` file inside its own folder under `plugins/slice/skills/`.
- Skills should favour aggregate/filter-first workflows and avoid dumping large raw records.
- Skill names use kebab-case (e.g. `cap-table-analysis`).

## Scripts

- `scripts/build-release-claude.sh` — Whitelist-based stager that flattens `plugins/slice/` into a zip whose root has the layout claude.ai expects. Run manually or via the `release.yml` workflow.
- `scripts/validate-versions.sh` — Checks all version fields against the canonical version. Run in CI via `validate_plugin.yml` and locally before pushing version bumps.
