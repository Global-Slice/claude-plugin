# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-19

### Changed

- **Renamed plugin** from `slice` to `slice-global` to use a brand-tied name (the unscoped `slice` namespace is shared with unrelated `slicejs` projects). MCP tools now appear under the `mcp__slice-global__*` prefix.
- Bumped to `1.0.0` for the first stable public release.
- Removed duplicate `version` field from the marketplace manifest plugin entry; `plugins/slice-global/.claude-plugin/plugin.json` is now the single source of truth.
- Marketplace `category` switched from `data` (not in Anthropic's official set) to `productivity`.
- Fixed `homepage` in `plugin.json` (was pointing at an unrelated `docs.slice.com` domain) to `https://github.com/Global-Slice/claude-plugin`.

### Removed

- `PreToolUse` hooks that injected per-call skill-loading directives. Claude Code already auto-invokes skills based on their frontmatter `description`, so the hooks were redundant token overhead.
- Unreferenced `assets/logo.png` (the plugin manifest schema has no icon field).

## [0.1.0] - 2026-05-11

### Added

- Initial public release: read-only Slice MCP plugin for Claude Code with 8 skills covering cap-table, securities, compliance, equity compensation, funding rounds, waterfall, workflows, and board presentation analysis.
