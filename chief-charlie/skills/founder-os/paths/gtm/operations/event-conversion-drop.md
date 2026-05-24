# Event — Conversion Drop

## Trigger

Any one of these:

- Funnel-stage conversion in `sales-playbook.md` drops > 30% vs the
  previous month (Discovery → Demo, Demo → Close, etc.)
- Pipeline coverage in `bookings-plan.md` drops below 3× quota for
  ≥2 consecutive weekly check-ins
- Cold-outreach reply rate (step 2.1) drops > 30% within an active
  channel-test that hasn't otherwise hit kill criteria
- Bookings (Net New ARR / Mo) flat for 2+ months while ARR continues
  to climb (Skok's hidden-stalled-business signal)

## Pre-flight

Read from `dashboard_data.json`:

- `path_state.roadmap.currentSubphase`
- `path_state.kpis.rows` — current vs target
- `path_state.warnings` — existing list

Read from logs:

- Last 3 entries from `monthly_review_log.jsonl`
- `weekly_checkin_log.jsonl` last 8 weeks
- `decisions_learnings.jsonl` since the drop began (look for changes
  introduced in that window)

Read from data sources:

- `sales-playbook.md` Stage-by-Stage table — which conversion fell?
- `channel-test.md` weekly logs (if step 2.1)
- `bookings-plan.md` Pipeline Coverage trend (if step 2.3)

## Action

### Step 1 — Notify the founder plainly

```
Conversion-Drop erkannt: {metric} ist von {prev}% auf {curr}% gefallen
({magnitude}-Punkte-Drop, {pct}% Veränderung).

Das triggert eine kurze Diagnose-Schleife. Ziel: Ursache eingrenzen
in den nächsten 15-20 Minuten, dann Fix-Decision.
```

Identify the affected funnel stage explicitly.

### Step 2 — Investigation prompts (in order)

Ask in sequence, log each answer to `decisions_learnings.jsonl`:

**1. Was hat sich seit dem letzten guten Monat verändert?**
- Produkt: neue Features, Bugs, UX-Änderungen?
- Audience: andere Zielgruppe / anderer Channel-Mix?
- Distribution: andere Lead-Source aktiv?
- Markt: Saisonalität, Wettbewerber-Move, externes Event?

**2. Welche Initiative ist seit dem letzten Monthly gelaufen?**
- ICP-Änderung über `icp-adjustment.md`?
- Messaging-Änderung über `messaging-adjustment.md`?
- Sales-Playbook-Update über `playbook-update.md`?
- Rep-Hire / Rep-Cut?
- Pricing-Change?
- Channel-Switch?

**3. Hast du einen anderen Pool gemessen als sonst?**
- Andere Cohort? (z.B. dieser Monat überdurchschnittlich Bad-Fit-Leads?)
- Anderes Sample-Size? (z.B. nur 5 Discovery-Calls statt sonst 30 →
  hohe Varianz, kein echter Drop)
- Anderes Stage-Filter? (z.B. plötzlich enge Definition von "demo")

### Step 3 — Stage-spezifische Diagnose

Depending on which conversion dropped:

**Discovery → Demo dropped:**
- Discovery-Script geändert? (route: `playbook-update.md` für
  `sales-playbook.md` Discovery-Section)
- Falsche ICP eingelassen, die kein Discovery durchhält? (route:
  `icp-adjustment.md` if pattern)
- Reps machen Discovery anders als trainiert? (route: weekly call
  reviews, Schatz black sheet)

**Demo → Close dropped:**
- Demo zu Feature-Tour mutiert, Story verloren? (route:
  `playbook-update.md` für `sales-playbook.md` Demo Section)
- Pricing-Pushback? (route: `unit-economics-model.md` Premium
  Pricing review)
- Neue Objection ohne Reframe in `objection-map.md`? (route:
  `playbook-update.md` für `objection-map.md`)

**Lead → Discovery dropped (Reply Rate / Book Rate):**
- Messaging-Drift (route: `messaging-adjustment.md` if pattern)
- Channel-Saturation (route: `event-channel-failed.md` consideration)
- Wrong list / audience drift (route: `channel-test.md` audit)

**Pipeline coverage dropped:**
- Lead supply problem (route: `marketing-sales-contract.md` review)
- Cycle time stretching (route: `bookings-plan.md` Pipeline Velocity)
- Win rate dropping per pod (route: rep-coaching cadence)

**Bookings flat while ARR rises (Skok hidden-stall signal):**
- Net New ARR breakdown: New shrinking? Expansion shrinking? Churn
  growing?
- Skok: ARR rise hides bookings flatline by 6 months. Don't ignore.
- Surface in `quarterly-rebuild.md` Section 6 if not already.

### Step 4 — Log finding

Append `learning` entry to `decisions_learnings.jsonl`:

```jsonl
{"type":"learning","date":"YYYY-MM-DD","category":"CONVERSION_DROP","stage":"{Discovery→Demo}","magnitude":"{drop pct}","root_cause":"{best hypothesis}","action":"{routed-to operation}"}
```

### Step 5 — Knowledge review suggestion

Recommend re-reading the relevant top-level file based on the affected
stage:

- Discovery / Demo / Close issues → `knowledge/gtm/repeatable-sales-motion.md`
  and `knowledge/gtm/founder-to-rep-handoff.md`
- Lead-supply / channel issues → `knowledge/gtm/scale-demand-and-sales.md`
- Pricing-pushback → `knowledge/gtm/unit-economics.md`

### Step 6 — Update path_state.warnings

Append:

```json
{
  "type": "conversion_drop",
  "at": "{today}",
  "stage": "{affected_stage}",
  "magnitude_pct": {N},
  "subphase": "{currentSubphase}",
  "next_action": "{routed-to operation}"
}
```

### Step 7 — Set fired-at timestamp

```
path_state.events.conversion_drop.last_fired_at = today
path_state.events.conversion_drop.last_stage = "{stage}"
```

Don't set a fired-once flag — this event should fire any time a stage
drops, not just once.

## Anti-pattern check

Before routing, sanity-check:

- **Sample size**: if N < 10 in the dropped stage, this might be
  variance, not a trend. Note in the learning entry but don't kick
  off heavyweight adjustments.
- **One-month spike vs trend**: prefer 2 consecutive months of drop
  before triggering `icp-adjustment.md` or `messaging-adjustment.md`.
  One bad month is not a hypothesis problem yet.

## Connection to other operations

- Detected by `weekly-checkin-review.md` (multiple Q6 variants)
- Detected by `monthly-review.md` (any step)
- May trigger downstream: `playbook-update.md`,
  `icp-adjustment.md`, `messaging-adjustment.md`,
  `event-channel-failed.md`, `unit-economics-model.md` review

## Rules

- **Never lead with the fix.** Diagnose first, route second. Otherwise
  you fix the wrong thing.
- **Watch the sample size.** Variance lies. 20 sample-size minimum
  before treating as a trend.
- **One change per session.** If the drop suggests multiple fixes,
  pick the most upstream and route. Schedule the others.
- **Bookings vs ARR distinction matters in 2.3+.** Don't conflate
  the two. ARR rising while bookings flat is a hidden problem (Skok).

## Related files

- `sales-playbook.md` — stage-by-stage conversion table
- `channel-test.md` — channel-level reply rate
- `bookings-plan.md` — pipeline coverage and velocity
- `unit-economics-model.md` — pricing diagnostic if Demo→Close drop
- `playbook-update.md`, `icp-adjustment.md`, `messaging-adjustment.md` —
  downstream routes
- `decisions_learnings.jsonl` — audit trail
- `knowledge/gtm/repeatable-sales-motion.md` — conversion-rate doctrine
- `knowledge/gtm/scale-demand-and-sales.md` — pipeline math
- `knowledge/gtm/matrix/skok-bookings-not-arr.md` — leading-indicator rule
- `knowledge/gtm/matrix/schatz-pipeline-forecasting.md` — coverage discipline
