#!/usr/bin/env bash
# Chief Charlie SessionStart hook
# Injects current Founder OS state from .founder-os/dashboard_data.json into context.

set -euo pipefail

DASHBOARD="${PWD}/.founder-os/dashboard_data.json"

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

emit() {
    local context="$1"
    local escaped
    escaped=$(escape_for_json "$context")
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${escaped}"
  }
}
EOF
    exit 0
}

# Case 1: no dashboard → first-time user
if [ ! -f "$DASHBOARD" ]; then
    emit "## Chief Charlie — Session Start

No Founder OS state found in this workspace (\`.founder-os/dashboard_data.json\` is missing).

This looks like a first-time session. Greet the user briefly and tell them to run **/onboarding** to set up their Chief Charlie folder and capture their founder identity. Do not start any founder work until onboarding is complete.

Workspace: \`${PWD}\`"
fi

# Case 2: dashboard exists → extract current state
if ! command -v jq >/dev/null 2>&1; then
    emit "## Chief Charlie — Session Start

A Founder OS dashboard exists at \`.founder-os/dashboard_data.json\` but \`jq\` is not installed, so the session-start hook cannot parse it.

Read the dashboard yourself with the Read tool to load current state. The user can install \`jq\` (\`brew install jq\` on macOS) to enable richer SessionStart context.

Workspace: \`${PWD}\`"
fi

# Pull key fields. Use // to default missing fields to "unknown".
CURRENT_PATH=$(jq -r '.path_state.current_path // .current_path // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
CURRENT_PHASE=$(jq -r '.currentPhase.title // .data.roadmap.currentSubphase // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
COMPANY=$(jq -r '.business_profile.company_name // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
ONBOARDING_DONE=$(jq -r '.path_state.onboarding_completed_at // "null"' "$DASHBOARD" 2>/dev/null || echo "null")
NEXT_CHECKIN=$(jq -r '.path_state.cadences.next_checkin_due // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
NEXT_MONTHLY=$(jq -r '.path_state.cadences.next_monthly_due // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
BOTTLENECK=$(jq -r '.bottleneck.title // .data.bottleneck.title // "none recorded"' "$DASHBOARD" 2>/dev/null || echo "none recorded")
ONE_THING=$(jq -r '.oneThing // .data.oneThing // "none recorded"' "$DASHBOARD" 2>/dev/null || echo "none recorded")
TODAY=$(date +%Y-%m-%d)

# Mid-onboarding
if [ "$ONBOARDING_DONE" = "null" ] || [ -z "$ONBOARDING_DONE" ]; then
    emit "## Chief Charlie — Session Start

Founder OS state exists but onboarding is incomplete (\`onboarding_completed_at\` is null).

Resume the /onboarding flow where the user left off. Read \`.founder-os/dashboard_data.json\` to see what's already captured.

Workspace: \`${PWD}\`"
fi

# Cadence check
CADENCE_ALERT=""
if [ "$NEXT_CHECKIN" != "unknown" ] && [ "$NEXT_CHECKIN" != "null" ] && [ "$NEXT_CHECKIN" \< "$TODAY" ]; then
    CADENCE_ALERT="${CADENCE_ALERT}- Weekly check-in is overdue (was due ${NEXT_CHECKIN}) — offer /weekly-checkin\n"
fi
if [ "$NEXT_MONTHLY" != "unknown" ] && [ "$NEXT_MONTHLY" != "null" ] && [ "$NEXT_MONTHLY" \< "$TODAY" ]; then
    CADENCE_ALERT="${CADENCE_ALERT}- Monthly review is overdue (was due ${NEXT_MONTHLY}) — offer /monthly-review\n"
fi
if [ -z "$CADENCE_ALERT" ]; then
    CADENCE_ALERT="- All cadences current.\n"
fi

emit "## Chief Charlie — Founder OS Dashboard Snapshot

Treat this as the current snapshot of \`dashboard_data.json\`. Use it for current state without re-reading the file. Re-read only when about to write, or when this block is missing.

- **Company:** ${COMPANY}
- **Current path:** ${CURRENT_PATH}
- **Current phase:** ${CURRENT_PHASE}
- **Current bottleneck:** ${BOTTLENECK}
- **One Thing this week:** ${ONE_THING}
- **Today:** ${TODAY}

### Cadence status
${CADENCE_ALERT}

### Greeting guidance
- Open with one sentence acknowledging where they are (phase + bottleneck).
- If a cadence is overdue, offer it before asking what they want to work on.
- Otherwise: ask one focused question about the One Thing.

Workspace: \`${PWD}\`"
