#!/bin/bash
set -euo pipefail

cat <<'EOF'
{"systemMessage": "You are about to call a Slice securities tool. If you have not already loaded the 'slice:securities-analysis' skill, invoke the Skill tool with skill 'slice:securities-analysis' BEFORE proceeding. The skill covers grants, shares, warrants, convertibles, and vesting timeline analysis patterns."}
EOF
