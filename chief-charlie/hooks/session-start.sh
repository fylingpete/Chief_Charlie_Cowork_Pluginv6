#!/usr/bin/env bash
# Chief Charlie SessionStart hook
# Injects (1) Chief Charlie account identity from Memphis and
#         (2) current Founder OS state from .founder-os/dashboard_data.json
# into the session context.

set -euo pipefail

DASHBOARD="${PWD}/.founder-os/dashboard_data.json"
AUTH_FILE="${HOME}/.chief-charlie/auth.json"
API_URL="${CHIEF_CHARLIE_API_URL:-https://api.chiefcharlie.ai}"

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

# ─────────────────────────────────────────────────────────────────────────────
# Block 1 — Account identity (from Memphis)
# ─────────────────────────────────────────────────────────────────────────────

build_account_block() {
    if [ ! -f "$AUTH_FILE" ]; then
        printf '%s' "## Chief Charlie Account

Not logged in. Tell the user (if relevant) they can run \`/login <jwt-token>\` to connect their Chief Charlie account and unlock account-specific features. The plugin still works fully without login — onboarding and Founder OS run locally."
        return
    fi

    if ! command -v jq >/dev/null 2>&1; then
        printf '%s' "## Chief Charlie Account

Auth token found but \`jq\` is not installed — cannot parse it. Suggest \`brew install jq\` on macOS. Account verification skipped this session."
        return
    fi

    local token
    token=$(jq -r '.token // empty' "$AUTH_FILE" 2>/dev/null)
    if [ -z "$token" ]; then
        printf '%s' "## Chief Charlie Account

Auth file exists but token is empty. User should re-run \`/login <jwt-token>\`."
        return
    fi

    if ! command -v curl >/dev/null 2>&1; then
        printf '%s' "## Chief Charlie Account

Auth token present but \`curl\` is not available — cannot verify against Memphis."
        return
    fi

    # Call Memphis /api/users/me. Time out fast so we don't block session start.
    local response status body
    response=$(curl -s -m 5 -w "\n%{http_code}" \
        -H "Authorization: Bearer ${token}" \
        "${API_URL}/api/users/me" 2>/dev/null || echo $'\n000')
    status=$(printf '%s' "$response" | tail -n1)
    body=$(printf '%s' "$response" | sed '$d')

    case "$status" in
        200)
            local first last email tz lang
            first=$(printf '%s' "$body" | jq -r '.first_name // ""')
            last=$(printf '%s' "$body" | jq -r '.last_name // ""')
            email=$(printf '%s' "$body" | jq -r '.email // ""')
            tz=$(printf '%s' "$body" | jq -r '.timezone // "Europe/Berlin"')
            lang=$(printf '%s' "$body" | jq -r '.language // "de"')
            printf '%s' "## Chief Charlie Account

- **Logged in as:** ${first} ${last} (${email})
- **Timezone:** ${tz}
- **Language:** ${lang}
- **Backend:** ${API_URL}

Greet the user by first name when appropriate."
            ;;
        401)
            printf '%s' "## Chief Charlie Account

Stored token is invalid or expired (Memphis returned 401). Tell the user to run \`/login <new-token>\` with a fresh token. Do NOT auto-delete the file — let the user decide."
            ;;
        000)
            printf '%s' "## Chief Charlie Account

Memphis at ${API_URL} is not reachable (network down, tunnel offline, or timeout). Token is stored; will retry next session. Plugin features that need backend are unavailable this session."
            ;;
        *)
            printf '%s' "## Chief Charlie Account

Memphis returned HTTP ${status} when verifying token. User may need to check backend status or re-login."
            ;;
    esac
}

ACCOUNT_BLOCK=$(build_account_block)

# ─────────────────────────────────────────────────────────────────────────────
# Block 2 — Founder OS dashboard snapshot
# ─────────────────────────────────────────────────────────────────────────────

# Case A: no dashboard → first-time founder OS user
if [ ! -f "$DASHBOARD" ]; then
    emit "${ACCOUNT_BLOCK}

---

## Chief Charlie — Founder OS State

No Founder OS state found in this workspace (\`.founder-os/dashboard_data.json\` is missing).

This looks like a first-time session in this folder. If the user hasn't run \`/onboarding\` yet, briefly mention they can. Do not start any founder work until onboarding is complete.

Workspace: \`${PWD}\`"
fi

# Case B: dashboard exists but jq missing
if ! command -v jq >/dev/null 2>&1; then
    emit "${ACCOUNT_BLOCK}

---

## Chief Charlie — Founder OS State

A Founder OS dashboard exists at \`.founder-os/dashboard_data.json\` but \`jq\` is not installed, so the session-start hook cannot parse it. Suggest \`brew install jq\`. You can also Read the dashboard yourself to load state.

Workspace: \`${PWD}\`"
fi

# Pull dashboard fields
CURRENT_PATH=$(jq -r '.path_state.current_path // .current_path // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
CURRENT_PHASE=$(jq -r '.currentPhase.title // .data.roadmap.currentSubphase // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
COMPANY=$(jq -r '.business_profile.company_name // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
ONBOARDING_DONE=$(jq -r '.path_state.onboarding_completed_at // "null"' "$DASHBOARD" 2>/dev/null || echo "null")
NEXT_CHECKIN=$(jq -r '.path_state.cadences.next_checkin_due // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
NEXT_MONTHLY=$(jq -r '.path_state.cadences.next_monthly_due // "unknown"' "$DASHBOARD" 2>/dev/null || echo "unknown")
BOTTLENECK=$(jq -r '.bottleneck.title // .data.bottleneck.title // "none recorded"' "$DASHBOARD" 2>/dev/null || echo "none recorded")
ONE_THING=$(jq -r '.oneThing // .data.oneThing // "none recorded"' "$DASHBOARD" 2>/dev/null || echo "none recorded")
TODAY=$(date +%Y-%m-%d)

# Case C: mid-onboarding
if [ "$ONBOARDING_DONE" = "null" ] || [ -z "$ONBOARDING_DONE" ]; then
    emit "${ACCOUNT_BLOCK}

---

## Chief Charlie — Founder OS State

State file exists but onboarding is incomplete (\`onboarding_completed_at\` is null). Resume the \`/onboarding\` flow where the user left off.

Workspace: \`${PWD}\`"
fi

# Case D: fully onboarded → cadence check + snapshot
CADENCE_ALERT=""
if [ "$NEXT_CHECKIN" != "unknown" ] && [ "$NEXT_CHECKIN" != "null" ] && [ "$NEXT_CHECKIN" \< "$TODAY" ]; then
    CADENCE_ALERT="${CADENCE_ALERT}- Weekly check-in is overdue (was due ${NEXT_CHECKIN}) — offer /weekly-checkin
"
fi
if [ "$NEXT_MONTHLY" != "unknown" ] && [ "$NEXT_MONTHLY" != "null" ] && [ "$NEXT_MONTHLY" \< "$TODAY" ]; then
    CADENCE_ALERT="${CADENCE_ALERT}- Monthly review is overdue (was due ${NEXT_MONTHLY}) — offer /monthly-review
"
fi
if [ -z "$CADENCE_ALERT" ]; then
    CADENCE_ALERT="- All cadences current.
"
fi

emit "${ACCOUNT_BLOCK}

---

## Chief Charlie — Founder OS Dashboard Snapshot

Treat this as the current snapshot of \`dashboard_data.json\`. Use it for current state without re-reading the file. Re-read only when about to write or when this block is missing.

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
