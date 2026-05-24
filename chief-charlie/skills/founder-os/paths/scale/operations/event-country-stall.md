# Event — Country Stall

## Trigger

Any one of these (per country — throttle per-instance):

- A launched country is contributing < 50% of Plan for 2 consecutive
   quarters
- Country CAC-Payback > 36 months for 2 consecutive quarterly readings
- Country Operating Loss > 1.5× planned through Month-18 of launch
- Country reaches Month-12 or Month-18 milestone (mandatory Kill-Criteria-
   check window from `kill-criteria.md`)
- `path_state.events.country_stall.last_fired_at` for this specific
   country is NULL OR ≥ 60 days ago

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.vector_state.countries_launched` (each country + months-since-launch)
- `path_state.events.country_stall` — per-country last-fired
- `path_state.cross_kpis` (context — overall Rule of 40 trajectory)

Read from templates:
- `country-similarity-matrix.md` — was this country picked correctly?
- `country-launch-playbook.md` — execution-quality questions
- `kill-criteria.md` — pre-written Kill-Criteria for this country

Read from logs:
- Last 3 `monthly_review_log.template.jsonl` entries — Country P&L sections
- Last 2 `quarterly_rebuild_log.template.jsonl` — Country decisions

## Action

### Step 1 — Notify the founder plainly

> "Signal: {{country}} ist {{months_since_launch}} Monate live und
> trägt {{actual_arr_share}}% New ARR (Plan: {{planned_arr_share}}%).
> Skok's Sequencing-Discipline: ein Land das < 50% of Plan für 2 Q
> ist ein Kill-Discussion-Trigger, nicht ein 'we'll see'-Trigger.
> Kill-Criteria pre-launch waren: {{kill_criteria_summary}}."

### Step 2 — Diagnose: what's stalling?

Walk through the failure modes (drawing from YC + Skok International
doctrine):

- **Wrong country picked (TAM-Trap):** was Similarity-Score höher
   für anderes Land? Re-read `country-similarity-matrix.md`.
- **Re-invention statt Replikation:** wurde der Home-Playbook 1:1
   replicated oder "improved on the way"? Re-read `country-launch-
   playbook.md` for adaptation log.
- **Wrong GM:** GWC™ on Country-GM seat — Get-it / Want-it / Capacity
   alle Y?
- **Localization mis-allocated:** product over-localized (per-country
   features), sales-motion under-localized (verbatim Home-cadence)?
- **Regulatory friction underestimated:** healthcare / finance /
   education certifications stalling deals?
- **Demand-side problem:** is buyer-behavior actually like Home, or
   was Similarity-Score wrong?

### Step 3 — Decision Path

**(A) Continue + Reset Plan**

- Acknowledge first plan was wrong (typical: 24-month break-even
   instead of 12).
- Re-baseline Country with new Plan.
- New Kill-Criteria (signed off) for next 6-12 Monate.
- Continue current GM mit refreshed mandate.

**(B) Replace Country-GM**

- GWC™ on current GM fails → search for replacement.
- Open `exec-90-day-plan.md` for new Country-GM.
- Current GM transitions out within 30-60 Tage with handoff.
- Country pauses material spend during transition.

**(C) Pivot Strategy (Centralize/Localize Adjustment)**

- Re-balance Centralize vs Localize allocation.
- Typical: pull product back to central (reduce branches), expand
   localization in sales/CS (more local discretion).
- Updated `country-launch-playbook.md` Country-Adaptation-Log.

**(D) Kill the Country (Pre-Written Kill-Criteria Match)**

- If Hard-Kill threshold matched: execute Kill.
- Country-staff offboard plan (typically 60-90 Tage).
- Reallocate spend to other vectors (next country, vertical-depth in core).
- Country flagged in `vector_state.countries_launched[*].killed_at: today`.
- Document in `kill-criteria.md` Month-18-Decision section.

### Step 4 — Execute the chosen decision

#### If A (Continue + Reset):
- Update `country-launch-playbook.md` mit new milestones.
- New Kill-Criteria signed off + dated.
- Communicated to Country-GM + Board.
- Append `monthly_review_log` mit `{country_reset: true, reason: ...}`.

#### If B (Replace GM):
- Open `exec-90-day-plan.md` for new GM.
- Document Three-Strike or Direct-Replacement-Decision (mit Rationale).
- Current GM transition plan documented.
- Update `accountability-chart.md` Country-GM seat status.

#### If C (Pivot Centralize/Localize):
- Update `country-launch-playbook.md` Stage 2.2 (Marketing-Cadence)
   + Stage 2.3 (First Sales-Conversations).
- Documented decisions in `decisions_learnings.jsonl`.
- New playbook version for next Country (learning captured).

#### If D (Kill):
- Update `kill-criteria.md` decision-section
- Update `path_state.vector_state.countries_launched[*].killed_at`
- Document offboard plan
- Append `decisions_learnings.jsonl`: `{type: "decision", domain: "vector",
   reasoning: "Killed {country} at month {N}: {Hard-Kill-Threshold hit};
   reallocating to {target}"}`

### Step 5 — Update path_state

```json
{
  "events": {
    "country_stall": {
      "last_fired_at": "today",
      "last_country": "{country}",
      "decision_taken": "A / B / C / D"
    }
  },
  "vector_state": {
    "countries_launched": [
      {
        "country": "{country}",
        "status": "active | killed | replaced_gm | pivoted",
        "last_event_at": "today"
      }
    ]
  }
}
```

## Anti-pattern check

Before routing:

- **Renegotiation attempt:** is someone arguing that Hard-Kill threshold
   was "too strict"? Documented in `kill-criteria.md` Renegotiation-Log.
   If yes: surface explicitly — DISCIPLINE TEST. Pre-written Criteria
   gilt.
- **Country < 12 Monate alt:** under-12-Monate ist nicht statistisch
   stabil. Wenn keine extreme Outlier-Reading: skip Kill-Decision,
   continue collecting Data.
- **External-Macro-Shock (currency crisis, regulatory shift):** war
   the Plan based on stable assumptions? Adjust comparison.
- **Country GM ist out-of-cone:** GWC™ Capacity fails in roles that
   require local-context. Re-check role-spec.

## Connection to other operations

- Detected by `monthly-review.md` Section 2.3a (Country-by-Country P&L)
- Detected by `weekly-checkin.md` Q6 (Step 3.3)
- Detected by `quarterly-rebuild.md` Section 7 (Vector / Country Kill-
   Criteria Check)
- Triggers downstream:
  - `kill-criteria.md` formal review
  - Potentially `exec-90-day-plan.md` for new GM (Decision B)
  - Potentially Vector-Decision-Doc re-eval (Decision D)

## Rules

- **Pre-Written Kill-Criteria gilt.** Retroactive Renegotiation NICHT
   akzeptiert.
- **Throttle 60 Tage per Country.** Same Country fires nicht repeat
   within 60 Tage. Different Countries fire ihre eigenen Events.
- **Country < 12 Monate alt → Anti-Pattern-Check kann Decision delayen.**
   Data muss stabil sein.
- **Documented Decision** A/B/C/D mit Rationale.
- **Killed-Country closed cleanly** — offboard plan, learnings captured.

## Related files

- `country-similarity-matrix.md` — original pick rationale
- `country-launch-playbook.md` — execution playbook
- `kill-criteria.md` — pre-written thresholds
- `accountability-chart.md` — Country-GM seat
- `exec-90-day-plan.md` — backfill if Decision B
- `knowledge/scale/international-expansion.md` — Step 3.3 doctrine
- `knowledge/scale/yc/yc-international-expansion.md` — Kill-Criteria origin
- `knowledge/scale/matrix/skok-phase11-domination-expansion.md` — Sequencing
