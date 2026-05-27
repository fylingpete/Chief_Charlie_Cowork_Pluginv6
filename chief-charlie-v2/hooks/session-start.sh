#!/usr/bin/env bash
# Chief Charlie SessionStart hook
#
# Emits a single instruction telling the assistant to load the Founder OS
# state from .founder-os/dashboard_data.json in the user's selected workspace
# folder. We do not try to locate the file from this hook, because in Cowork
# there is no reliable env var that points at the user-selected workspace —
# $PWD is the temporary outputs scratchpad, not the workspace. Delegating to
# the assistant (which has scoped file access to the selected workspace)
# works in both Claude Code and Cowork.

set -euo pipefail

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

CONTEXT="Lade meinen Founder OS State aus .founder-os/dashboard_data.json in meinem ausgewählten Workspace-Folder."

escaped=$(escape_for_json "$CONTEXT")
cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${escaped}"
  }
}
EOF
