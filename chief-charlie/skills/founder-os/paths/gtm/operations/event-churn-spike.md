# Event — Churn Spike

## Trigger

Any one of these:

- 12-month logo retention drops below 85% (or below the previous
  monthly review by ≥5 points)
- Net Dollar Retention (NDR) drops below 100% (loses Negative Churn
  status) OR drops ≥10 points M-o-M
- Activation rate drops ≥20% M-o-M for 2 consecutive monthly
  measurements
- Churn count this month > 2× the previous 3-month average
- Channel-attributed retention reveals a channel producing
  fast-churners that's growing share

## Pre-flight

Read from `dashboard_data.json`:

- `path_state.roadmap.currentSubphase` (typically 2.4 or 2.5)
- `path_state.kpis.rows`
- `path_state.warnings`

Read from logs and templates:

- `monthly_review_log.jsonl` — last 3 entries
- `churn_reason_log.jsonl` — last 30 days of churn events
- `activation-metric-doc.md` — Cohort Performance, Channel-Attributed
  Activation
- `onboarding-flow.md` — Cohort Performance table
- `unit-economics-model.md` — Channel-Attributed Retention (if step 2.5)
- `decisions_learnings.jsonl` since the last good month

## Action

### Step 1 — Notify the founder plainly

```
Churn-Spike erkannt:
- 12mo Logo-Retention: {prev}% → {curr}% ({delta})
- NDR: {prev}% → {curr}%
- Aktivierungsrate: {prev}% → {curr}% (Cohort {month})

Skok: Churn spikt typischerweise GENAU dann, wenn Sales skaliert.
Der Fix ist meistens upstream — ICP, Sales-Promise, Onboarding —
nicht im CS-Team.

Lass uns 30 Min in die Diagnose gehen.
```

### Step 2 — Root-Cause-Klassifikation jeder Churn

Pull each churn event from `churn_reason_log.jsonl` from the last 30 days.
For each, classify into one of 6 root causes (Skok's framework):

| Root Cause | Signal | Upstream Fix |
|---|---|---|
| **ICP-Mismatch** | Bad-fit customer who shouldn't have closed | `icp-adjustment.md` |
| **Sales-Promise-Mismatch** | Customer thought they were buying X, got Y | `messaging-adjustment.md` or `playbook-update.md` for handoff |
| **Activation-Failure** | Never reached Wow moment, gave up | `onboarding-flow.md` friction audit |
| **Product-Fit-Failure** | Product genuinely doesn't solve their problem | back to PMF (Phase 1) for that segment |
| **Champion-Departure** | Champion left company / changed role | re-onboarding play in `onboarding-flow.md` |
| **External** | Customer's company died / pivoted / lost budget | not fixable, log and move on |

For each churn event, pick the dominant root cause. Note that a single
churn can have multiple — pick the one that's most upstream.

### Step 3 — Pattern detection

After classifying all churns, count by root cause:

```
Root-Cause Distribution (last 30 days):
- ICP-Mismatch: {N}
- Sales-Promise-Mismatch: {N}
- Activation-Failure: {N}
- Product-Fit-Failure: {N}
- Champion-Departure: {N}
- External: {N}
```

The dominant root cause defines the upstream fix.

**If ICP-Mismatch dominates:**
> "Das ist klassisch das Skok-Phänomen: Sales skaliert, ICP-Disziplin
> lockert, falsche Kunden kommen rein. Der Fix ist NICHT mehr CS — es
> ist der negative ICP in `icp-doc.md` zu schärfen, plus
> Marketing-Filter in `marketing-sales-contract.md` zu härten."
> → Route: `icp-adjustment.md` or `playbook-update.md` for negative ICP

**If Sales-Promise-Mismatch dominates:**
> "Reps over-promisen, Customer fühlt sich getäuscht in Onboarding.
> Hand-off-Kriterien in `sales-playbook.md` und `onboarding-flow.md`
> Sales-to-Onboarding-Inputs müssen geprüft und eingehalten werden."
> → Route: `playbook-update.md` für `sales-playbook.md` Hand-off und
> Coaching-Cadence verschärfen

**If Activation-Failure dominates:**
> "Customers reichen die Wow-Moment nicht. Time-to-Wow ist zu lang
> oder Onboarding-Flow hat zu viel Friktion."
> → Route: `playbook-update.md` für `onboarding-flow.md` Friction Audit
> und ggf. `activation-metric-doc.md` re-validieren (ist die Metric
> überhaupt noch predictive?)

**If Product-Fit-Failure dominates:**
> "Das ist ernster — Product löst das Problem nicht für diese Cohort.
> Wenn das nicht ICP-Mismatch ist (Bad-fit), ist das ein PMF-Problem
> für diese Sub-Segment."
> → Surface that 2.4 cannot fix this; the user must consider
> PMF-revisit for the affected segment OR de-emphasize that segment.

**If Champion-Departure dominates:**
> "Kein Upstream-Fix nötig — wir brauchen ein Re-Onboarding-Playbook
> für neue Champions plus Frühwarnung für Champion-Departure."
> → Route: `playbook-update.md` für `onboarding-flow.md` Champion
> Identification and re-onboarding play

**If External dominates:**
> "Das ist nicht fixbar von uns. Aber: tracken — wenn 'External' > 30%,
> die Markt-Exposition ist zu konzentriert (z.B. alle Kunden in einer
> Industrie, die gerade kontrahiert)."
> → No immediate route; consider in `quarterly-rebuild.md` Section 2
> (ICP audit — pick a less concentrated segment?)

### Step 4 — Channel-Attributed Retention Check

If on step 2.5, additionally pull channel-attributed retention from
`unit-economics-model.md`:

- Channel with worst retention: ___
- Is that channel growing share?
- Channel CAC × bad retention = LTV destroyer

If a single channel produces > 50% of the churn:
- Consider killing or de-emphasizing the channel
- Route to `unit-economics-model.md` review and possibly
  `event-channel-failed.md` if the channel-CAC is also bad

### Step 5 — Quick Wins (CS-side, while upstream fixes are scheduled)

While upstream fixes are routed, identify CS-side quick wins:

- Re-engage at-risk accounts proactively (signals from
  `activation-metric-doc.md` At-Risk-Account-Signals)
- Surface champion-departure risks via the alerting in
  `onboarding-flow.md`
- Run a "win-back" outreach to recently-churned customers (interview
  for root cause if not yet classified)

### Step 6 — Log finding

Append to `decisions_learnings.jsonl`:

```jsonl
{"type":"learning","date":"YYYY-MM-DD","category":"CHURN_SPIKE","retention_delta":"{prev}%→{curr}%","ndr_delta":"{prev}%→{curr}%","dominant_root_cause":"{root_cause}","action":"{routed-to-operation}"}
```

### Step 7 — Update path_state.warnings

Append:

```json
{
  "type": "churn_spike",
  "at": "{today}",
  "retention_12mo": {N},
  "ndr": {N},
  "dominant_root_cause": "{root_cause}",
  "subphase": "{currentSubphase}",
  "next_action": "{routed-to-operation}"
}
```

### Step 8 — Set fired timestamp

```
path_state.events.churn_spike.last_fired_at = today
path_state.events.churn_spike.last_root_cause = "{root_cause}"
```

This event can fire multiple times (different root causes, different
spike events).

## Anti-pattern check

- **Don't add CS headcount as the response.** That's the most common
  founder-instinct, and Skok says it's almost always wrong. CS is
  downstream, churn root causes are upstream.
- **Don't kill a channel based on one bad cohort.** Two cohorts of
  bad retention, then consider it. Variance in early cohorts is high.
- **Don't blame the customer.** "They didn't really fit" is sometimes
  true, but more often "we shouldn't have sold to them" — that's a
  fixable upstream problem.

## Connection to other operations

- Detected by `monthly-review.md` Step 2.4 / 2.5
- Detected by `quarterly-rebuild.md` Section 7 (Activation & Retention
  Cohorts)
- Detected by `weekly-checkin-review.md` Q6 in step 2.4
- May trigger downstream:
  - `icp-adjustment.md` if ICP-Mismatch
  - `messaging-adjustment.md` if Sales-Promise-Mismatch
  - `playbook-update.md` for `onboarding-flow.md`,
    `sales-playbook.md`, `activation-metric-doc.md`
  - `event-channel-failed.md` if channel-attributed
  - PMF-revisit for affected segment if Product-Fit-Failure dominates

## Rules

- **Diagnose root cause first.** Don't trigger fixes before
  classification.
- **Most fixes are upstream.** ICP, sales hand-off, onboarding — in
  that order of frequency. CS-side fixes are last resort.
- **Cohort-based retention only.** Snapshot retention lies — don't
  trigger this event off snapshots.
- **Pattern, not a single churn.** One bad cohort is variance. Two
  consecutive months of decline is a trend.

## Related files

- `activation-metric-doc.md` — predictive validation, channel-attributed
  activation
- `onboarding-flow.md` — friction audit, champion identification
- `unit-economics-model.md` — channel-attributed retention (step 2.5)
- `icp-doc.md` — negative ICP that should have prevented bad-fit churn
- `sales-playbook.md` — hand-off-to-CS criteria
- `marketing-sales-contract.md` — MQL fit-criteria filters
- `churn_reason_log.jsonl` — append-only churn event log
- `knowledge/gtm/activation-and-retention.md` — Step 2.4 doctrine
- `knowledge/gtm/matrix/skok-phase7-customer-success.md` — root-cause framework
- `knowledge/gtm/matrix/skok-negative-churn.md` — NDR > 100% mechanics
- `knowledge/gtm/yc/yc-improving-retention.md` — behavioral signal method
