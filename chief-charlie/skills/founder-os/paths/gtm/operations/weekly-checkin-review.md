# GTM Weekly Check-In

5 minutes. Run when `next_checkin_due <= today` OR user requests.

## Pre-flight

Read `dashboard_data.json` → `path_state.cadences.last_checkin_at` and
`path_state.roadmap.currentSubphase`. Compute `weeks_since_last`. Greet:
"Check-In {{N}} — let's go quick. Step {{currentSubphase}}."

## Question 0 — Recap (open)

**Q0:** "Was ist seit deinem letzten Check-In passiert? Was war das
Wichtigste? Was war gut oder schlecht?"

→ Append to `weekly_checkin_log.jsonl` as
  `{type: "recap", raw: "<user answer>"}`
→ Parse the answer for:
  - learning candidates (draft buffer for `decisions_learnings.jsonl`,
    category auto-detect: ICP / MSG / SALES / ONBOARD / RETAIN / CHANNEL)
  - decision candidates
  - bottleneck mentions (compare to current `bottleneck.title` and
    `roadmap_defaults.steps[currentSubphase].bottlenecks`)
  - numbers (e.g. calls / meetings / conversion → pre-fill Q1)
  - "next week I want to..." statements (task candidates)
→ When asking Q1-Q6 below, FIRST check if the answer was already given
  in Q0. If yes, confirm instead of re-asking:
  "Du hast {{X}} erwähnt — als {{type}} speichern? (j/n)"

## Standard questions (1-5, every step)

1. **Calls / meetings this week?** (number)
   → if `currentSubphase` ≥ "2.2", also ask conversion rate (Discovery
   → Demo, Demo → Close) if known
2. **Größte Erkenntnis dieser Woche?** → log to
   `decisions_learnings.jsonl` as `learning`, category=auto-detect
   (ICP / MSG / SALES / ONBOARD / RETAIN / CHANNEL)
3. **Wichtigste Entscheidung dieser Woche?** ("none" valid) → log as
   `decision` if non-empty
4. **Was hat dich zurückgehalten?** → if differs from current
   `bottleneck.title`, update it (and surface the
   `roadmap_defaults.steps[currentSubphase].bottlenecks` for matching)
5. **Eine Sache, die du nächste Woche anders machst?** → create task
   with `today: false`, add date = next Monday

## Step-specific Q6

Pick the question matching `currentSubphase`:

### 2.1 — Find a repeatable sales motion

**Q6:** Hat dein gewählter Channel diese Woche genug Volumen erzeugt?
Was war das Reply-/Response-Rate?
→ log learning, category=CHANNEL
→ if reply rate < threshold for 2 weeks → suggest `event-channel-failed.md`

### 2.2 — Prove non-founders can sell

**Q6:** Welche Einwände hast du oder dein Rep in Calls am häufigsten
gehört? Sind die im `objection-map.md` schon drin?
→ log learning, category=SALES
→ if pattern emerging (3+ times) → nudge `playbook-update.md` for
  `objection-map.md`

### 2.3 — Make growth scalable

**Q6:** Wie ist die Pipeline-Coverage diese Woche? Welcher Channel
trägt aktuell wieviel?
→ log learning, category=CHANNEL
→ if pipeline coverage drops below 3× → flag in
  `path_state.warnings`

### 2.4 — Ensure customers succeed

**Q6:** Wieviele neue Customers haben diese Woche das Activation-Event
erreicht? Median Time-to-Wow?
→ log learning, category=ONBOARD or RETAIN
→ if activation rate drops 2 weeks in a row → suggest
  `event-churn-spike.md` review

### 2.5 — Make it profitable

**Q6:** Was war diese Woche der CAC pro Channel? Hat sich was
verschoben?
→ log learning, category=CHANNEL or RETAIN
→ if any single channel CAC > 2× target → flag in `path_state.warnings`

## Wrap

- Append to `weekly_checkin_log.jsonl`:
  ```jsonl
  {"date":"YYYY-MM-DD","path":"gtm","subphase":"{currentSubphase}","completed":true,"answers":{...}}
  ```
- Update `dashboard_data.json`:
  - `path_state.cadences.last_checkin_at = today`
  - `path_state.cadences.next_checkin_due = today + 7 days`
- Confirm to user: "Check-In gespeichert. Bis nächste Woche."

## Watch-signals (auto-flagged, surfaced in next check-in)

After every check-in, check these triggers and surface in the user's next
session if hit:

- `event-channel-failed`: reply rate / conversion below kill criteria
  in `channel-test.md` for 2+ check-ins
- `event-conversion-drop`: any funnel-stage conversion drops > 30% vs
  last month
- `event-churn-spike`: 12mo logo retention or NDR drops below threshold
- `event-2.5-milestone`: all three Phase 8 gates pass simultaneously

These don't auto-fire from inside the check-in — they get added to
`path_state.events_pending` and surface at the start of the next user
session via the master onboarding hook.

## Rules

- **5 minutes is the budget.** If a question opens a bigger
  conversation, capture it as a learning and route to a deeper
  operation (call-debrief, icp-adjustment, etc.).
- **One question at a time** — do not batch.
- **Don't re-ask if user already answered in conversation context** —
  use what they said and confirm.
- **Q0 first, always.** Use Q0 to short-circuit Q1-Q6 wherever
  possible — don't re-ask what the user already said.

## Deprecated fields — do NOT write

The following fields exist in older workspaces but are no longer
rendered by any UI. Do NOT write or update them during the check-in:

- `data.currentPhase`
- `data.coreAssumption`
- `data.decision`
- `data.evidence`
- Any `data.doNotDo.*` bucket other than `home` (only `data.doNotDo.home` is rendered — "Don't do yet" on home.json)
