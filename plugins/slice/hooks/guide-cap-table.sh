#!/bin/bash
set -euo pipefail

cat <<'EOF'
{"systemMessage": "You are about to call a Slice cap-table tool. If you have not already loaded the 'slice:cap-table-analysis' skill, invoke the Skill tool with skill 'slice:cap-table-analysis' BEFORE proceeding. The skill explains aggregate/filter-first workflows and how to avoid dumping large raw records."}
EOF
