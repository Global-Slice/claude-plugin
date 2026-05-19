# AGENTS.md

Contributor guide for AI agents working on the Slice Claude plugin marketplace.

## Repository layout

```text
claude-plugin/
├── .claude-plugin/marketplace.json           # Marketplace manifest (lists all plugins)
├── .github/
│   ├── workflows/
│   │   ├── validate_plugin.yml               # PR: claude plugin validate + version sync
│   │   ├── release.yml                       # Tag push: build zip + GitHub Release
│   │   └── auto-tag.yml                      # Main push: auto-tag on version bump
│   └── dependabot.yml                        # GitHub Actions updates
├── scripts/
│   ├── build-release-claude.sh               # Stage plugins/slice-global/ → dist/slice-claude-<v>.zip
│   └── validate-versions.sh                  # Keep marketplace.json + plugin.json in sync
├── plugins/slice-global/                     # The slice-global plugin
│   ├── .claude-plugin/plugin.json            # Plugin manifest (canonical version source)
│   ├── .mcp.json                             # MCP server config (Slice HTTP endpoint)
│   └── skills/                               # Claude skills (one folder per skill)
├── AGENTS.md                                 # This file
├── CHANGELOG.md                              # Keep-a-Changelog format
├── LICENSE                                   # MIT
└── README.md                                 # Install instructions + permanent zip URL
```

## Version-bump checklist

The canonical version lives in `plugins/slice-global/.claude-plugin/plugin.json`. When bumping:

1. Update `version` in `plugins/slice-global/.claude-plugin/plugin.json` (source of truth).
2. Update `metadata.version` in `.claude-plugin/marketplace.json`. **Do not** add a `version` field to the plugin entry inside `marketplace.json` — `plugin.json` is the only source of truth.
3. Add a new dated entry to `CHANGELOG.md`.
4. Merge to `main` — the `auto-tag.yml` workflow creates the git tag automatically.

Run `bash scripts/validate-versions.sh` locally to verify all version fields match before pushing.

## Adding a new skill

1. Create `plugins/slice-global/skills/<skill-name>/SKILL.md`.
2. Write a clear, model-invokable `description:` in the YAML frontmatter — this is how Claude Code decides when to load the skill, so include "Use when…" trigger phrases for the topics the skill covers.
3. Update the skill list in `plugins/slice-global/README.md` and the root `README.md`.

> The plugin no longer ships `PreToolUse` hooks. Skills are auto-loaded from their frontmatter `description`; do not reintroduce hooks just to "guarantee" a skill loads.

## Skill conventions

- Each skill is a single `SKILL.md` file inside its own folder under `plugins/slice-global/skills/`.
- Skills should favour aggregate/filter-first workflows and avoid dumping large raw records.
- Skill names use kebab-case (e.g. `cap-table-analysis`).

## Scripts

- `scripts/build-release-claude.sh` — Whitelist-based stager that flattens `plugins/slice-global/` into a zip whose root has the layout claude.ai expects. Run manually or via the `release.yml` workflow.
- `scripts/validate-versions.sh` — Checks all version fields against the canonical version. Run in CI via `validate_plugin.yml` and locally before pushing version bumps.
