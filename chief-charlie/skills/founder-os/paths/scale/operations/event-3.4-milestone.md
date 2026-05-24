# Event — 3.4 Milestone Reached (Scale Complete → Operating Mode)

## Trigger

`scale-complete-checklist.md` shows all SIX Conditions TRUE
simultaneously:

1. Additional Vector ≥ 20% Total ARR with own positive Unit Economics
2. Core Focus™ held (off-cone declines documented ≥ 1)
3. NDR ≥ 110% sustained ≥ 4 consecutive quarters
4. Rule of 40 ≥ 40 sustained ≥ 4 consecutive quarters
5. Org-Checkup™ ≥ 80 sustained
6. Kill-Criteria written + applied ≥ 1× (kept oder closed against
   Pre-Written Criteria)

PLUS:
- `path_state.events.scale_34_milestone.fired` is not `true`
   (terminal — fires once per path)
- Last 2 monthly reviews confirm all 6 conditions held — kein One-Off-Spike

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.kpis.rows` (current Step 3.4 KPIs)
- `path_state.cross_kpis` (Rule of 40, NDR, LH-Score — full year)
- `path_state.events.scale_34_milestone` (fired flag)
- `path_state.vector_state` — vectors launched, off-cone declines

Read from templates:
- `scale-complete-checklist.md` — all 6 Conditions Detail
- `vto.md` — V/TO™ current state
- `vector-decision-doc.md` — vectors decided across path

Read from logs:
- Last 12 `monthly_review_log.template.jsonl` (full year sustained)
- Last 4 `quarterly_rebuild_log.template.jsonl` (full year quarterly)
- `decisions_learnings.jsonl` since Scale-Path start — for journey-Highlights
- `cross_kpi_log.template.jsonl` full year

## Action

### Step 1 — Acknowledge explicitly

> "Alle sechs Scale-Complete-Conditions sind grün:
>
> 1. Additional Vector trägt {{vector_arr_share}}% Total ARR ({{vector_name}})
> 2. Core Focus™ hielt — {{off_cone_declines_count}} off-cone-Opportunities documented declined
> 3. NDR = {{ndr_current}}% sustained {{ndr_quarters}} Quartale
> 4. Rule of 40 = {{ro40_current}} sustained {{ro40_quarters}} Quartale
> 5. Org-Checkup™ = {{org_checkup}} sustained
> 6. Kill-Criteria angewandt — {{kill_criteria_application_example}}
>
> Du bist Scale Complete. Im Founder-OS-Framework heißt das: keine
> Phase 4. Du switchst auf Operating Mode."

### Step 2 — Summarize the Scale journey

Pull from `decisions_learnings.jsonl` + `cross_kpi_log` over full path:

- **Cross-KPI Arc:** where did each Cross-KPI start, where they are now?
  - Rule of 40: {{start}} → {{now}}
  - NDR: {{start}} → {{now}}
  - LH-Score: {{start}} → {{now}}
- **Top 5 Decisions** that moved Scale forward (pricing, channel, hire,
   vector-pick, kill-decisions)
- **Top 5 Learnings** that mattered (org-pattern, EOS™ install, country
   replication, vector validation)
- **Sub-phase journey:** how long in 3.1 / 3.2 / 3.3 / 3.4?
- **Hardest moment:** which event-driven crisis was the biggest learning?

### Step 3 — Confirm Leadership-Team + Board Sign-Off

Walk through `scale-complete-checklist.md` Leadership Sign-Off section:

- **All Leadership-Members signed individually:** yes / pending
- **Board acknowledgment received:** yes / pending
- **Open objections from Leadership oder Board:**

If pending: pause Operating-Mode-Switch until full sign-off.

### Step 4 — Present Operating Mode

```
Du switchst von Scale Path zu Operating Mode.

Was das bedeutet:
- Kein neuer Path. Kein Phase 4. Das System ist final.
- Cadences continue indefinitely:
  • L10™ weekly
  • Monthly Review (mit Cross-KPI-Refresh)
  • Quarterly Rocks™ Planning (3-4h)
  • Annual Planning Session (2 Tage)
- Cross-Step KPIs continue:
  • Rule of 40, NDR, Leadership-Health-Score
  • Sustained-Green ist die ongoing Discipline
- Events stay active:
  • event-cac-payback-blowout (Unit-Economics Drift)
  • event-leadership-vacancy (Org-Health)
  • event-ndr-below-100 (Retention-Drift)
  • event-org-checkup-below-70 (Leadership-Health-Drift)

Was sich ändert:
- "Next-Step" Recommendation: deaktiviert
- Roadmap-UI: shows "Path Complete — Operating Mode"
- Phase-Change-Operation: no-op (no more sub-phases)
- Scale-Complete-Checklist: gelockt v1-locked, archived

Was du jetzt machst:
- Continue running L10™, Monthly Review, Quarterly Rocks™, Annual.
- Founder-OS surfaces Cross-KPI-Drift wenn es passiert.
- Bei materiellen Strategie-Shifts: Annual Planning ist die Re-Foundation.

Confirme den Switch?
```

### Step 5 — Execute Operating Mode Switch

After user confirmation:

```json
{
  "current_path": "scale",
  "path_state": {
    "operating_mode": true,
    "operating_mode_activated_at": "today",
    "scale_complete_at": "today",
    "events": {
      "scale_34_milestone": {
        "fired": true,
        "fired_at": "today",
        "leadership_signoff_complete": true,
        "board_acknowledged": true
      }
    }
  }
}
```

Update `roadmap.badge: "Path Complete — Operating Mode"`.
Update `scale-complete-checklist.md` status: v1-locked.

Cadences continue running — `cadences.next_*_due` are computed normally.

### Step 6 — Append Audit-Trail

```jsonl
{"type":"milestone","date":"YYYY-MM-DD","domain":"scale-path","milestone":"3.4_scale_complete","cross_kpis_at_complete":{"rule_of_40":...,"ndr":...,"lh_score":...},"sustained_quarters":...,"path_switch_decision":"operating_mode_confirmed"}
```

## Anti-pattern check

Before celebrating:

- **One-off Spike:** are all 6 Conditions grün for ≥ 2 consecutive
   monthly reviews? Single-month-grünen reicht nicht.
- **Sustained 4 Quartale:** Cross-KPIs müssen wirklich 4 konsekutive
   Quartale grün sein — nicht "3 von 4".
- **Org-Checkup™ ≥ 80 sustained ist easy to misread:** wenn ein
   Component-Score ist 75 aber Aggregat ist 81, ist der Component
   das Real-Signal. Re-check component-level.
- **Founder still routing decisions?** Cond 5 (LH-Score) ≥ 80 ist
   meaningless wenn Founder funktional immer noch Integrator ist.
   Re-test: in den letzten 4 Wochen, wie oft kam eine Cross-Functional
   Decision direkt zum Founder?
- **No off-cone-declines documented:** Cond 2 fails. Vector hat zu
   wenig Discipline-Test bekommen.

## Connection to other operations

- Detected by `monthly-review.md` Section 2.4d (Scale-Complete-Checklist
   Progress)
- Detected by `quarterly-rebuild.md` Section 4 (3.4 Deep-Dive)
- Terminates `phase-change.md` (no further sub-phases)
- Locks `scale-complete-checklist.md` to v1-locked

## Rules

- **Fires EXACTLY ONCE per path.** This is the terminal event.
- **Don't auto-switch.** Operating-Mode-Switch is user-confirmed.
- **Anti-pattern-check VOR Operating-Mode-Switch.** One-off Spikes
   trick the trigger.
- **Surface remaining risks** even when celebrating (Founder-Bottleneck,
   Cross-KPI sustained-vs-Spike).
- **Board acknowledged + Leadership signed.** Skipping diese steps =
   invalid milestone.
- **Cadences continue** — Operating Mode ist nicht "we're done", es ist
   "we're stable. Keep running the operating system."

## Related files

- `scale-complete-checklist.md` — the 6 Conditions + Leadership Sign-Off
- `vector-decision-doc.md` — vector(s) decided in 3.4
- `vto.md` — V/TO™ that held across Scale
- `cross_kpi_log.template.jsonl` — full-year evidence
- `knowledge/scale/product-line-expansion.md` — 3.4 doctrine + Terminal-State
- `knowledge/scale/scale-org-and-processes.md` — Operating-Mode org pattern
