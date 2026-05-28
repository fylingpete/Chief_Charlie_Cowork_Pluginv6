#!/usr/bin/env bash
# Chief Charlie sync-file probe hook (PostToolUse — Write|Edit)
#
# PROBE-ONLY rc3 version. Logs to stderr (captured in session JSONL) so
# we don't depend on $HOME-based file IO which proved unreliable in
# Co-Work (rc1/rc2 file at $HOME/cc_sync_probe.log never materialized
# in any findable location).
#
# Also attempts a secondary write to ${CLAUDE_PLUGIN_DATA}/probe.log to
# verify whether the plugin data dir is set and writable.
#
# Grep for "===PROBE===" in the session JSONL to find this output.
#
# Failure mode: every error path exits 0 — never break the user's
# write/edit flow because of a probe hook bug.

set +e
PAYLOAD="$(cat 2>/dev/null || true)"

# All diagnostics → stderr (lands in JSONL hook_success attachment).
{
  echo "===PROBE=== start $(date -u +%FT%TZ)"
  echo "===PROBE=== argv (count=$#)"
  i=0; for a in "$@"; do echo "===PROBE===   [$i] $a"; i=$((i+1)); done
  echo "===PROBE=== HOME=${HOME:-<unset>}"
  echo "===PROBE=== PWD=${PWD:-<unset>}"
  echo "===PROBE=== CLAUDE_PLUGIN_ROOT=${CLAUDE_PLUGIN_ROOT:-<unset>}"
  echo "===PROBE=== CLAUDE_PLUGIN_DATA=${CLAUDE_PLUGIN_DATA:-<unset>}"
  echo "===PROBE=== CLAUDE_PROJECT_DIR=${CLAUDE_PROJECT_DIR:-<unset>}"
  echo "===PROBE=== ALL_CLAUDE_ENV:"
  env | grep -E '^(CLAUDE_|TOOL_|HOOK_)' | sort | sed 's/^/===PROBE===   /' || echo "===PROBE===   (none)"
  echo "===PROBE=== stdin payload (raw):"
  echo "$PAYLOAD" | sed 's/^/===PROBE===   /'
  if command -v jq >/dev/null 2>&1; then
    echo "===PROBE=== parsed tool_name        : $(printf '%s' "$PAYLOAD" | jq -r '.tool_name // "<missing>"' 2>/dev/null)"
    echo "===PROBE=== parsed tool_input.file_path : $(printf '%s' "$PAYLOAD" | jq -r '.tool_input.file_path // "<missing>"' 2>/dev/null)"
    echo "===PROBE=== parsed cwd              : $(printf '%s' "$PAYLOAD" | jq -r '.cwd // "<missing>"' 2>/dev/null)"
    FP="$(printf '%s' "$PAYLOAD" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
  else
    echo "===PROBE=== jq not available"
    FP=""
  fi
  if [ -n "$FP" ] && [ -e "$FP" ]; then
    DIR="$(cd "$(dirname "$FP")" 2>/dev/null && pwd || echo /)"
    FOUND=""
    while [ "$DIR" != "/" ] && [ -n "$DIR" ]; do
      if [ -f "$DIR/.chiefcharlie/project.json" ]; then
        FOUND="$DIR/.chiefcharlie/project.json"
        break
      fi
      DIR="$(dirname "$DIR")"
    done
    if [ -n "$FOUND" ]; then
      echo "===PROBE=== walk-up project.json found: $FOUND"
    else
      echo "===PROBE=== walk-up project.json: not found above $FP"
    fi
  else
    echo "===PROBE=== walk-up: skipped (no resolvable file_path)"
  fi
  # Secondary persistence experiment: try CLAUDE_PLUGIN_DATA
  if [ -n "${CLAUDE_PLUGIN_DATA:-}" ]; then
    if mkdir -p "$CLAUDE_PLUGIN_DATA" 2>/dev/null && \
       echo "$(date -u +%FT%TZ) wrote here from probe" >> "$CLAUDE_PLUGIN_DATA/probe.log" 2>/dev/null; then
      echo "===PROBE=== persisted to CLAUDE_PLUGIN_DATA/probe.log OK"
    else
      echo "===PROBE=== persistence to CLAUDE_PLUGIN_DATA/probe.log FAILED"
    fi
  else
    echo "===PROBE=== CLAUDE_PLUGIN_DATA unset — cannot test persistence"
  fi
  echo "===PROBE=== end"
} >&2

# Clean stdout — empty hookSpecificOutput so Co-Work doesn't try to parse
# probe data as additionalContext.
cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PostToolUse"
  }
}
EOF
exit 0
