# Scale Weekly Check-In

5 minutes (default mode) / 30-60 minutes (L10™ mode, automatic from Step 3.2+).
Run when `next_checkin_due <= today` OR user requests.

## Pre-flight

Read `dashboard_data.json` → `path_state.cadences.last_checkin_at` and
`path_state.roadmap.currentSubphase`. Compute `weeks_since_last`. Greet:
"Check-In {{N}} — Step {{currentSubphase}}."

**Mode detection:**

- `currentSubphase` in `{3.1}` → **Default Mode** (5 Min, Q0-Q6).
- `currentSubphase` in `{3.2, 3.3, 3.4}` → **L10™ Mode** (30-60 Min,
  full Wickman Level 10 Meeting agenda). User can override with
  `path_state.cadence_mode = "default"` for a single week.

Surface mode to user:

> "Step {{currentSubphase}} → L10™ Mode. Volle 7-Item-Agenda mit IDS™.
> Wenn du heute nur Quick-Pulse machen willst, sag 'default'."

## Question 0 — Recap (open, always)

**Q0:** "Was ist seit deinem letzten Check-In passiert? Was war das
Wichtigste? Was war gut oder schlecht?"

→ Append to `weekly_checkin_log.jsonl` as
  `{type: "recap", raw: "<user answer>"}`
→ Parse for: learning candidates (auto-detect category: GATES /
  TROUGH / POD / CHANNEL / ORG / VECTOR), decision candidates,
  bottleneck mentions, numeric signals, "next week I want to..."
  statements.
→ Use Q0 to short-circuit Q1-Q6 — confirm instead of re-ask.

---

## Default Mode (Step 3.1)

### Standard questions

1. **Drei Gates Status (kurz):** Hat sich seit letzter Woche was
   bewegt — LTV:CAC / CAC-Payback / NDR?
   → log learning, category=GATES if numeric shift
2. **Größte Erkenntnis dieser Woche?**
   → log to `weekly_checkin_log.jsonl` as `learning`
3. **Wichtigste Entscheidung dieser Woche?** ("none" valid)
4. **Was hat dich zurückgehalten?**
   → if differs from current `bottleneck.title`, surface
   `roadmap_defaults.steps[3.1].bottlenecks` for matching
5. **Eine Sache, die du nächste Woche anders machst?**
   → create task with `today: false`, date = next Monday

### Q6 — Step 3.1 specific

**Q6:** Wie ist die Channel-Auslastung diese Woche — und CAC-Burn?
Hat sich Lead-Mix verschoben?
→ log learning, category=CHANNEL
→ if Channel #1 saturation signs (CPL +>20% w-o-w trotz Targeting) →
  flag in `path_state.warnings`
→ if CAC-Payback projected > 24 Monate → suggest `event-cac-payback-blowout.md`

---

## L10™ Mode (Step 3.2, 3.3, 3.4) — Wickman's Level 10 Meeting

7-Item-Agenda mit gelockten Time-Boxes. Leadership-Team only (in
practice: Founder + Integrator + Function-Heads). Same day, same time.

### Item 1 — Segue (5 Min)

> "Jeder ein Satz: ein gutes Signal aus der Woche (Business oder
> Personal). No discussion."

→ log to weekly_checkin_log as `{type: "segue", note: ...}`

### Item 2 — Scorecard™ Review (5 Min, report-only)

Read `scorecard.md` rows from `paths/scale/templates/scorecard.md`.
Pro Row: Owner reports "on-track" oder "off-track". **Keine
Discussion** — Misses dropen in Item 6 (IDS™).

→ Append `scorecard_history.template.jsonl` mit weekly snapshot:
  `{rows, red_cells_count, all_owners_reporting}`

### Item 3 — Rock™ Review (5 Min, report-only)

Pro Quarterly Rock™ Owner: "on-track" oder "off-track" für Quarter-
End-Completion. Off-track → IDS™.

→ Update `path_state.rock_status` (in cross_kpi_log oder dedicated
  rocks_completion_log on quarter close).

### Item 4 — Customer / Employee Headlines (5 Min)

Ein-Satz-Updates. Good news → brief acknowledge. Bad news → IDS™.

### Item 5 — To-Do Review (5 Min)

Last week's To-Dos: binary done / not-done. Target ~90% completion.
To-Do > 2 Wochen open ist itself ein Signal.

### Item 6 — IDS™ (60 Min) — Identify, Discuss, Solve

Take top 3 Issues from Items 2-5 + Long-Term-Issues-List in V/TO™
that need this quarter's attention.

**Per Issue:**
1. **Identify** — Root cause, nicht Symptom. Frag: "warum?" 3-5x.
2. **Discuss** — Nur lange genug für Verständnis. NICHT zerreden.
3. **Solve** — Single named Owner + Single named To-Do. Binary done
   by next L10.

→ Each IDS resolution → append `weekly_checkin_log.jsonl` as
  `{type: "ids", issue: ..., owner: ..., to_do: ..., resolution_date: ...}`

### Item 7 — Conclude (5 Min)

1. Meeting-Lead reads back alle neuen To-Dos (Owner hört es).
2. Team entscheidet was an org communiziert wird.
3. Each Attendee rated Meeting 1-10. **Target > 8.** Less than 7
   triggert in nächster Woche eine Process-IDS.

→ Update `weekly_checkin_log` mit `l10_meeting_rating: avg`.

---

## Step-Specific Q6 — L10™ Mode Add-ons

After the standard 7-Item-Agenda, ask EINE step-specific Q6 als Wrap-Up.

### Step 3.2 — Scale the organization & processes

**Q6:** Wie war die L10™-Discipline diese Woche — alle in der Zeit,
alle Scorecard™-Rows reported, IDS™ nicht abgekürzt?
→ log learning, category=ORG
→ if L10™ over-time 2+ Wochen in row → flag `path_state.warnings`
→ if Acc-Chart-Seat open > 30 Tage → suggest `event-leadership-vacancy.md`

### Step 3.3 — Expand internationally

**Q6:** Country-Funnel-Status — wie steht das erste Land vs. Plan?
Welche localization-Friktion ist neu aufgetaucht?
→ log learning, category=VECTOR + country tag
→ if Country < 50% of Plan für 2 Quartale → suggest `event-country-stall.md`

### Step 3.4 — Add additional product lines

**Q6:** Vector-Health diese Woche — Pre-Sells progress (wenn Second-
Product) oder Vector-Adoption (wenn Geographic / M&A)? Hat NDR sich
bewegt?
→ log learning, category=VECTOR
→ if NDR drops < 110% sustained 2+ Wochen → flag in
  `path_state.warnings` + surface NDR-Below-100 trigger

---

## Wrap

- Append to `weekly_checkin_log.template.jsonl`:
  ```jsonl
  {"date":"YYYY-MM-DD","path":"scale","subphase":"{currentSubphase}","mode":"default|l10","completed":true,"answers":{...},"l10_meeting_rating":...,"flags":[...]}
  ```
- Update `dashboard_data.json`:
  - `path_state.cadences.last_checkin_at = today`
  - `path_state.cadences.next_checkin_due = today + 7 days`
- If L10™ Mode + Scorecard updated: append `scorecard_history.template.jsonl`
- Confirm to user: "Check-In gespeichert. Bis nächste Woche."

## Watch-signals (auto-flagged, surfaced in next check-in)

After every check-in, add to `path_state.events_pending` if triggers
hit. They don't auto-fire — they surface at start of next session.

- `event-cac-payback-blowout`: CAC-Payback > 24 Mo für 2 Quartale
  (detected in 3.1)
- `event-leadership-vacancy`: Acc-Chart-Seat open > 30 Tage (3.2)
- `event-country-stall`: Country < 50% Plan für 2 Q (3.3)
- `event-3.4-milestone`: All Scale-Complete-Checklist conditions met
  (3.4 terminal)
- `phase-change`: All deliverables of current sub done + readyWhen met

## Rules

- **5 Min budget in Default Mode (3.1), 90 Min budget in L10™ Mode (3.2+).**
  L10™ over 90 Min decay's das Tool — flag if it happens.
- **Scorecard + Rock Review sind report-only.** Discussion gehört in IDS™.
- **Same day, same time, same agenda** for L10™. Drift = Tool-Death.
- **Mode is currentSubphase-driven**, nicht user-preference. Override
  per session ist okay; permanent override braucht `path_state.cadence_mode`.
- **Don't re-ask if user already answered in Q0.** Use what they said.
- **One question at a time** — do not batch.

## Deprecated fields — do NOT write

- `data.currentPhase`
- `data.coreAssumption`
- `data.decision`
- `data.evidence`
- `data.doNotDo.focus`
