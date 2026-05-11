#!/bin/bash
set -euo pipefail

cat <<'EOF'
{"systemMessage": "You are about to call a Slice workflows tool. If you have not already loaded the 'slice:workflows-analysis' skill, invoke the Skill tool with skill 'slice:workflows-analysis' BEFORE proceeding. The skill covers workflow state analysis, pending payments, and tax-withholding patterns."}
EOF
