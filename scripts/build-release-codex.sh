#!/usr/bin/env bash
# Build the ZIP for the OpenAI plugin portal (platform.openai.com/plugins).
#
# Produces dist/slice-codex-<version>.zip from plugins/slice-global/ with
# .codex-plugin/plugin.json, .mcp.json, assets/logo.png, and skills/ at the
# zip root.
#
# The package must keep declaring the Slice MCP server (mcpServers ->
# ./.mcp.json): the portal rejects an upload that drops the plugin's existing
# MCP. Do not add .app.json / "apps" — the portal rejects app references.
#
# Usage: ./scripts/build-release-codex.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_SRC="${REPO_ROOT}/plugins/slice-global"
manifest="${PLUGIN_SRC}/.codex-plugin/plugin.json"

command -v zip >/dev/null 2>&1 || { echo "error: 'zip' is required" >&2; exit 1; }

grep -q '"mcpServers"[[:space:]]*:[[:space:]]*"\./\.mcp\.json"' "${manifest}" \
  || { echo "error: ${manifest} must declare \"mcpServers\": \"./.mcp.json\"" >&2; exit 1; }
[[ -f "${PLUGIN_SRC}/.mcp.json" ]] || { echo "error: missing ${PLUGIN_SRC}/.mcp.json" >&2; exit 1; }
# The portal blocks submission without an app icon ("App icon required").
[[ -f "${PLUGIN_SRC}/assets/logo.png" ]] || { echo "error: missing ${PLUGIN_SRC}/assets/logo.png" >&2; exit 1; }

version="$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "${manifest}" | head -n1)"
[[ -n "${version}" ]] || { echo "error: could not read version from ${manifest}" >&2; exit 1; }

zip_path="${REPO_ROOT}/dist/slice-codex-${version}.zip"
mkdir -p "${REPO_ROOT}/dist"
rm -f "${zip_path}"

# Whitelist: only the manifest, the MCP config, the icon, and skill markdown are shipped.
(cd "${PLUGIN_SRC}" && zip -qX "${zip_path}" .codex-plugin/plugin.json .mcp.json assets/logo.png skills/*/*.md)

echo "==> Built ${zip_path}"
unzip -l "${zip_path}"
