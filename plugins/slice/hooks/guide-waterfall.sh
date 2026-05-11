#!/bin/bash
set -euo pipefail

cat <<'EOF'
{"systemMessage": "You are about to call a Slice waterfall tool. If you have not already loaded the 'slice:waterfall-analysis' skill, invoke the Skill tool with skill 'slice:waterfall-analysis' BEFORE proceeding. The skill explains exit waterfall modelling and proceeds distribution analysis."}
EOF
