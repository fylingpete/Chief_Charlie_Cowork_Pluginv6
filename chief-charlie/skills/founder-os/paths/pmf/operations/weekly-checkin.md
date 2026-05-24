# PMF Weekly Check-In

5 minutes. Run when `next_checkin_due <= today` OR user requests.

## Pre-flight
Read `dashboard_data.json` → `path_state.cadences.last_checkin_at`.
Compute `weeks_since_last`. Greet: "Check-In {{N}} — let's go quick."

## Question 0 — Recap (open)

**Q0:** "Was ist seit deinem letzten Check-In passiert? Was war das
Wichtigste? Was war gut oder schlecht?"

→ Append to `weekly_checkin_log.jsonl` as
  `{type: "recap", raw: "<user answer>"}`
→ Parse the answer for:
  - learning candidates (draft buffer for `decisions_learnings.jsonl`)
  - decision candidates
  - bottleneck mentions (compare to current `bottleneck.title`)
  - numbers (e.g. survey responses → pre-fill Q1)
  - "next week I want to..." statements (task candidates)
→ When asking Q1-Q6 below, FIRST check if the answer was already given
  in Q0. If yes, confirm instead of re-asking:
  "Du hast {{X}} erwähnt — als {{type}} speichern? (j/n)"

## Questions

1. **New survey responses this week?** (number)
2. **Größte Erkenntnis dieser Woche?** → log to decisions_learnings.jsonl as `learning`, category=auto-detect
3. **Wichtigste Entscheidung dieser Woche?** ("none" valid) → log as `decision` if non-empty
4. **Was hat dich zurückgehalten?** → if differs from current `bottleneck.title`, update it
5. **Eine Sache, die du nächste Woche anders machst?** → create task with `today: false`, add date = next Monday
6. **PMF-specific:** Hast du diese Woche mit ≥1 Very-Disappointed-User gesprochen? Was hast du gelernt? → log learning + nudge HXC profile update if found

## Rules

- **5 minutes is the budget.** If a question opens a bigger
  conversation, capture it as a learning and route to a deeper
  operation (call-debrief, hxc-update, etc.).
- **One question at a time** — do not batch.
- **Q0 first, always.** Use Q0 to short-circuit Q1-Q6 wherever
  possible — don't re-ask what the user already said.

## Wrap

- Append to `weekly_checkin_log.jsonl`: `{date, path: "pmf", completed: true, answers}`
- Update `dashboard_data.json`:
  - `path_state.cadences.last_checkin_at = today`
  - `path_state.cadences.next_checkin_due = today + 7 days`
- Confirm to user: "Check-In gespeichert. Bis nächste Woche."

## Deprecated fields — do NOT write

The following fields exist in older workspaces but are no longer rendered
by any UI. Do NOT write or update them during the check-in:

- `data.currentPhase`
- `data.coreAssumption`
- `data.decision`
- `data.evidence`
- Any `data.doNotDo.*` bucket other than `home` (only `data.doNotDo.home` is rendered — "Don't do yet" on home.json)

If the user asks about them, explain they are deprecated and offer to
remove them in a cleanup pass.
