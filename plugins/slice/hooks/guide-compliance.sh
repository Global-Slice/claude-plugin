#!/bin/bash
set -euo pipefail

cat <<'EOF'
{"systemMessage": "You are about to call a Slice compliance tool. If you have not already loaded the 'slice:compliance-analysis' skill, invoke the Skill tool with skill 'slice:compliance-analysis' BEFORE proceeding. The skill explains compliance ticket posture assessment and object-level compliance analysis workflows."}
EOF
