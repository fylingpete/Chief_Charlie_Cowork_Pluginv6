# Event — Organizational Checkup™ Below 70

## Trigger

Any one of these:

- Most recent `cross_kpi_log` entry shows `lh_score.value < 70`
- Component-level Score < 60 in any of the 6 EOS™ Components (Vision /
   People / Data / Issues / Process / Traction) — fires regardless of
   aggregate score
- Org-Checkup™ Score moved backwards quarter-over-quarter by > 5 points
- `path_state.events.org_checkup_below_70.last_fired_at` is NULL OR
   ≥ 90 days ago (throttle — Org-Checkup™ läuft 2× im Jahr, event
   throttle matched dazu)

Note: This event only fires from Step 3.2 onwards. In Step 3.1 the
LH-Score floor is ≥ 70 (Step-Exit-Floor); in 3.2-3.4 the target is
≥ 80. Below 70 in any phase past 3.1 is a leadership-crisis signal.

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.cross_kpis.lh_score` — current value + as_of date
- `path_state.events.org_checkup_below_70` — last-fired metadata
- `path_state.roadmap.currentSubphase`
- `path_state.org_state` — Integrator status, EOS™ install status

Read from logs:
- Last 4 entries `cross_kpi_log.template.jsonl` — LH-Score trajectory
- Last 2 entries `monthly_review_log.template.jsonl` — Org-Checkup™
   component-level breakdown (read `lh_score.checkup_components`)

Read from templates:
- `accountability-chart.md` — current Seats + Open-Seats-Status
- `people-analyzer.md` — Below-Bar cases
- `vto.md` — V/TO™ existence + cascade health
- `scorecard.md` — Scorecard™ stability

## Action

### Step 1 — Notify the founder plainly

> "Signal: Organizational Checkup™ Score ist auf {{current_score}}
> gefallen (Target ≥ 80; Floor ≥ 70). Wickman ist explizit: das System
> läuft am Speed der schwächsten Component. Wenn das Aggregat unter 70
> ist, sind mindestens 2-3 Components materiell broken.
>
> Component-Breakdown (last reading):
> - Vision: {{vision_score}}
> - People: {{people_score}}
> - Data: {{data_score}}
> - Issues: {{issues_score}}
> - Process: {{process_score}}
> - Traction: {{traction_score}}"

### Step 2 — Diagnose: which Component(s) driving the drop?

Identify Component(s) < 60 (priority for fix) + Component(s) 60-79
(secondary). Per Component-Type, walk through typical failure modes:

#### Vision Component
- V/TO™ stale or never refreshed annually?
- Core Focus™ becoming aspirational vs. testable?
- 10-Year Target™ unbelievable to leadership?
- 3-Year Picture™ disconnected from 1-Year Plan?
- Annual Planning Session skipped or delegated?

#### People Component
- Open Acc-Chart Seats > 30 Tage? (cross-ref `event-leadership-vacancy.md`)
- People Analyzer™ Below-Bar cases unaddressed?
- GWC™ ambiguity (`+/-` slipped into GWC™ columns)?
- Wrong-Person-Right-Seat or Right-Person-Wrong-Seat tolerated?
- Three-Strike-Rule cases stagnating?

#### Data Component
- Scorecard™ rows > 15 (too many) or < 5 (too few — desert-island fail)?
- Rows with no named owner or "team" as owner?
- Outcome-metrics on Scorecard™ instead of Leading-Indicators?
- Goals on Scorecard™ disconnected from V/TO™ 1-Year Plan?
- 3+ konsekutive misses on multiple rows (real trend, not noise)?

#### Issues Component
- Issues-List not maintained (no L10™ Item 6 entries last 4 weeks)?
- IDS™ shortened to "discuss" without solve?
- Long-Term Issues never reach quarterly Section 8 (`quarterly-rebuild.md`)?
- Repeat-Issues (same root cause appearing multiple times)?

#### Process Component
- Core Processes™ identified but never documented (Stage 1 done, Stage 2 not)?
- Documents exist on shared drive but never compiled / trained?
- Process-Adherence not measured in Scorecard™ rows?
- Three-Step-Documenter™ stalled mid-implementation?

#### Traction Component
- Rocks™ completion rate < 50% (Wickman calibration norm, but if
   sustained > 3 Quartale = real problem)?
- L10™ over-time or under-rated (avg < 8.0)?
- Meeting-Pulse™ drift (L10™ moves around, quarterly-planning skipped)?
- Rocks™ overcommit (> 7 per Leader)?

### Step 3 — Decision Path

**(A) Component-Focus Quarter**

- Pick the WORST component (lowest score).
- Make next-Quarter's Rocks™ majority focused on that component
   (e.g. 4 of 7 company Rocks address People-Component issues).
- Set explicit Rebuild-Project in `path_state.projects`.
- Re-run Org-Checkup™ at mid-quarter (interim, not 6-month rhythm) to
   measure progress.

**(B) Outside-EOS-Implementer-Engagement**

- Wenn 3+ Components < 70 oder Aggregat < 60: das ist beyond DIY-fix.
- Engage an external EOS-Implementer™ (Wickman-zertifiziert) für a
   formal Day-of-Discovery oder 90-Day-Boot-Camp.
- Document the engagement plan + budget in `path_state.warnings`.

**(C) Integrator-Replacement (if People-Component drives)**

- Wenn People-Component < 50 + Integrator-Seat has been the cause
   (GWC™ fails on Integrator or persistent below-bar): trigger
   `event-leadership-vacancy.md` für Integrator-Seat.
- Höchste Priorität — Integrator broken bricht alle anderen Tools.

**(D) V/TO™ Off-Cycle Refresh (if Vision-Component drives)**

- Wenn Vision-Component < 60: don't wait for Annual Planning Session.
- Schedule 1-2 day Off-Site jetzt — full V/TO™ + 3-Year-Picture™
   rebuild.
- Update `paths/scale/operations/annual-planning.md` referenced
   process — run it now, then run again at scheduled annual date.

**(E) Roll-back to Foundational Tools (if multiple Components broken)**

- Wenn Vision + People + Data + Issues alle < 70: EOS™-Install ist
   degraded. Re-Install in Wickman-Reihenfolge:
   1. Accountability Chart™ refresh (structure first, names second)
   2. Rocks™ (binary scoring)
   3. Meeting Pulse™ + L10™ (90 Min weekly)
   4. Scorecard™ (5-15 leading indicators)
   5. V/TO™ (only after 1-4 stable)
   6. Core Processes™ (last)
- This is essentially re-starting Step 3.2 — surface to user.

### Step 4 — Execute the chosen decision

#### If A (Component-Focus Quarter):
- Update `vto.md` Page 2 with Component-focused Rocks™.
- Re-run `quarterly-rebuild.md` Section 9 (New Rocks Setting) early
   if necessary.
- Schedule interim Org-Checkup™ (4-6 weeks out, not 6 months).

#### If B (External EOS™ Implementer):
- Document engagement in `decisions_learnings.jsonl`.
- Add to `path_state.warnings`: `{"type": "eos_implementer_engaged", "until": "..."}`
- Cadences continue but external help is leading them temporarily.

#### If C (Integrator-Replacement):
- Fire `event-leadership-vacancy.md` for Integrator seat.
- Update `accountability-chart.md` mit Integrator-Seat als Open.
- Top-Priority recruiter engagement.

#### If D (V/TO™ Off-Cycle Refresh):
- Schedule 1-2 day Off-Site within 30 days.
- Run `annual-planning.md` operation (sections 2-9) outside the
   scheduled annual rhythm.
- Update `vto.md` to v2.

#### If E (Roll-back to Foundational Tools):
- Re-set `path_state.roadmap.currentSubphase = "3.2"` if currently
   3.3 or 3.4 (going backwards = honest signal).
- Project plan for 90-Day Re-Install.
- Surface to Board explicitly — this is significant.

### Step 5 — Update path_state

```json
{
  "events": {
    "org_checkup_below_70": {
      "last_fired_at": "today",
      "last_score": "{{lh_score}}",
      "worst_components": ["..."],
      "decision_taken": "A / B / C / D / E"
    }
  },
  "warnings": [...]
}
```

Append `decisions_learnings.jsonl`:

```jsonl
{"type":"decision","date":"YYYY-MM-DD","domain":"org-health","reasoning":"Org-Checkup-Below-70 event: score={{value}}, worst_component={{name}} at {{score}}, chose {A/B/C/D/E}: {1-sentence}"}
```

## Anti-pattern check

Before routing:

- **First-time Checkup with low baseline:** Wickman ist explicit that
   first-time Org-Checkup™ Scores often start in the 50-65 range —
   that's expected, not crisis. Skip event-firing if this is the FIRST
   Checkup-Reading + Score > 50.
- **Aggregate vs Component:** Aggregate ≥ 70 but Component < 60 is
   different signal — the Component is what fires, not aggregate.
- **Scoring-Methodology-Drift:** if the team has gotten more honest
   (newer scoring is more critical than prior), Score can drop
   without underlying degradation. Surface this question to user.
- **External-Shock (org reorg, key-exec departure, M&A close):** if
   recent material event changed leadership structure: Score-Drop
   may be transitional. Document but don't auto-route to A-E for one
   reading.

If any check fires: log to `path_state.warnings` mit
`org_checkup_drop_noise_filtered` and skip Steps 3-5 for this firing.

## Connection to other operations

- Detected by `monthly-review.md` Section 1 (Cross-KPI Refresh,
   LH-Score row) — when fresh reading is available
- Detected by `quarterly-rebuild.md` Section 6 (Org-Checkup™ + GWC™
   Review)
- Detected by `annual-planning.md` Section 6 (full Org-Checkup™ Run)
- Triggers downstream:
  - `event-leadership-vacancy.md` (Decision C)
  - Quarterly Rocks™ majority-rebalance (Decision A)
  - V/TO™ Refresh out-of-cycle (Decision D)
  - Sub-Phase rollback (Decision E)

## Rules

- **Fires from Step 3.2 onwards only.** Step 3.1 has different
   LH-Score expectation (≥ 70 floor, not ≥ 80 target).
- **Throttle 90 Tage** — matched zu typical Org-Checkup™ Cadence
   (2× pro Jahr).
- **Component-level matters more than Aggregate.** Component < 60
   fires regardless of Aggregate.
- **First-Checkup-Reading filter** — wenn das die erste Reading ist,
   nicht panic-fire.
- **Decision E (Roll-back) wird Board kommuniziert.** Das ist nicht
   ein quiet-fix.
- **No "we'll see in 6 months."** Components < 60 brauchen explicite
   Decision A-E innerhalb 90 Tage.

## Related files

- `cross_kpi_log.template.jsonl` — LH-Score history mit Component-Breakdown
- `accountability-chart.md` — People-Component focus
- `vto.md` — Vision-Component focus
- `scorecard.md` — Data-Component focus
- `people-analyzer.md` — People-Component (Below-Bar cases)
- `event-leadership-vacancy.md` — Decision C trigger
- `annual-planning.md` — Decision D out-of-cycle V/TO™ Refresh
- `quarterly-rebuild.md` — Decision A Rocks-rebalance
- `knowledge/scale/wickman/wickman-six-components.md` — Six Components™ + Checkup™ source
- `knowledge/scale/scale-org-and-processes.md` — Step 3.2 doctrine
- `monthly-review.md` — first detection point
