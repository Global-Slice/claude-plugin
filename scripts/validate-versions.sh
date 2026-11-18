#!/usr/bin/env bash
# Validates that all plugin version fields match the canonical version in
# plugins/slice/.claude-plugin/plugin.json.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

canonical_file="plugins/slice-global/.claude-plugin/plugin.json"
canonical=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "${REPO_ROOT}/${canonical_file}" | head -n1)

if [[ -z "${canonical}" ]]; then
  echo "error: could not read version from ${canonical_file}" >&2
  exit 1
fi

echo "Canonical version: ${canonical} (from ${canonical_file})"
echo

files=(
  ".claude-plugin/marketplace.json"
)

errors=0
for rel in "${files[@]}"; do
  file="${REPO_ROOT}/${rel}"
  if [[ ! -f "${file}" ]]; then
    echo "MISSING  ${rel}"
    (( errors++ )) || true
    continue
  fi
  versions=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "${file}")
  if [[ -z "${versions}" ]]; then
    echo "NO_VERSIONS ${rel}: no \"version\" fields found in ${file}"
    (( errors++ )) || true
    continue
  fi
  while IFS= read -r found; do
    if [[ "${found}" != "${canonical}" ]]; then
      echo "MISMATCH ${rel}: expected ${canonical}, found ${found}"
      (( errors++ )) || true
    fi
  done <<< "${versions}"
done

if [[ "${errors}" -eq 0 ]]; then
  echo "All version fields match ${canonical}."
else
  echo
  echo "error: ${errors} version mismatch(es) found." >&2
  exit 1
fi
