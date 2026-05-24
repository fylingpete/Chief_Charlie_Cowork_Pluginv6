# Event — NDR Below 100%

## Trigger

Any one of these (with throttle):

- Combined NDR < 100% for 2 consecutive monthly readings (read from
   `cross_kpi_log.template.jsonl`)
- Single-month NDR drop > 10 percentage points vs prior month (sudden
   shock — fires immediately, doesn't wait for second confirmation)
- Combined NDR < 110% sustained 4+ months while in step 3.4 (the
   Scale-Complete-Condition #3 is degrading — early warning)
- `path_state.events.ndr_below_100.last_fired_at` is NULL OR ≥ 60 days
   ago (throttle — don't re-fire same-quarter unless new shock)

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.cross_kpis.ndr` — current value + as_of date
- `path_state.events.ndr_below_100` — last-fired metadata
- `path_state.roadmap.currentSubphase` (NDR matters in different ways
   per step — 3.1 = gate-check, 3.4 = scale-complete-condition)

Read from logs:
- Last 6 entries `cross_kpi_log.template.jsonl` — full NDR trajectory
- Last 3 entries `monthly_review_log.template.jsonl` — context

Read from templates:
- `three-gate-dashboard.md` Gate-3 row (NDR is one of three Scale gates)
- `vector-decision-doc.md` (if currentSubphase == 3.4 — vector might be
   diluting NDR)

## Action

### Step 1 — Notify the founder plainly

> "Signal: Combined NDR ist auf {{current_ndr}}% gefallen (Target
> > 100% für Phase-9-Gate, > 110% sustained für Scale-Complete-
> Condition #3). Skok's Diagnose: NDR < 100% ist single-biggest
> SaaS-Schwäche — du wächst nur über Net-New-Logos und jeder neue
> Customer wird durch melting Cohorts diluted.
>
> Step {{currentSubphase}} Bedeutung: {{step_specific_meaning}}."

**Step-specific meaning hint:**
- 3.1: Gate-Status: aggressive Skalierung pausieren bis NDR > 100% wieder
- 3.2: Org-Health-Signal: Retention-Function in Acc-Chart hat Gap
- 3.3: Country-Retention vs Home-Retention vergleichen
- 3.4: Scale-Complete-Condition gefährdet — Vector möglicherweise
   verdünnt Combined NDR

### Step 2 — Diagnose: why is NDR dropping?

Walk through the failure modes (drawing from Skok Negative-Churn doctrine):

- **Onboarding failure:** Customers die nie productive wurden — können
   nicht re-engaged werden at Renewal. Check Activation-Metric-Cohort
   data (if available in `path_state.activation_signals`).
- **Champion left:** Original Buyer ist gone, neuer Stakeholder kennt
   den Value nicht. Quarterly Champion-Check verfügbar?
- **Pricing-Axes fehlen:** Flat-Pricing macht negative dollar churn
   mathematisch unmöglich. Check `path_state.pricing.axes`.
- **Bad-Segment-Drift:** Sales hat Segmente angeschrieben mit
   strukturell low-LTV (z.B. SMB-Burner-Channels in Scale-Mode).
- **Vector dilutes Core (3.4 specific):** Second-Product oder M&A-
   Customer hat schlechtere Retention als Core — Combined NDR drops
   aber Core NDR hält noch.
- **Product-Degradation:** Recent Releases haben unaddressed Bug
   patterns die Churn driven — check Customer-Complaint-Patterns.

### Step 3 — Decision Path

**(A) Pause Vector / Pause Skalierung**

- Wenn currentSubphase ∈ {3.3, 3.4} und NDR-Drop ist post-Vector-Launch:
   Vector-Investment pausieren, Core-Retention-Audit first.
- Wenn currentSubphase == 3.1 und NDR < 100%: aggressive Hiring/Channel-
   Spend pausieren — Gate-Bypass-Risk.
- Update `path_state.warnings` mit `{"type": "retention_first", "reason": ...}`.

**(B) Activation-Audit + Onboarding-Fix**

- Read `monthly_review_log` für Activation-Cohort-Patterns (wenn vorhanden).
- Run Activation-Audit-Session: welche Customers haben Activation-Event
   NICHT erreicht in den letzten 90 Tagen?
- Re-engineer Onboarding-Flow if needed (Salsify-Pattern: 5-Step → 3-Step).
- Cross-Reference `paths/gtm/templates/onboarding-flow.md` (template
   exists in GTM, applicable hier).

**(C) Pricing-Axes-Redesign**

- Wenn Pricing flat ist: Seats / Usage / Editions / Add-ons designen
   als Expansion-Axes.
- Skok: NDR > 100% mathematically unmöglich ohne Variable-Pricing.
- Achtung: Pricing-Redesign auf Existing-Customers ist Monate-of-Pain
   bei Scale-Volumen. Grandfather-Strategie planen.

**(D) Champion-Reset auf At-Risk-Accounts**

- Identify Accounts wo Original-Champion gone is (Sales/CS-Data).
- Resell-Play: neuen Champion finden, ROI-Evidence aktiv kommunizieren.
- Hormozi 4-R's Reminder: Review / Referral / Retain / Resell.

**(E) Bad-Segment-Kill + Reallocation**

- Wenn LTV:CAC by Segment zeigt structural-low-LTV-Source: kill segment.
- Reallocate spend to high-LTV-segments (HubSpot 12→2 / 4→25 Pattern).
- Update `channel-portfolio.md` mit Kill-Decision.

### Step 4 — Execute the chosen decision

#### If A (Pause):
- Update `path_state.warnings`: `{"type": "scale_paused", "reason": "ndr_below_100", "until_condition": "NDR > 105% for 2 consecutive months"}`
- Communicate to Leadership + Board explicitly.
- Pod-Cloning paused (per `pod-charter.md` clone-decision-log).

#### If B (Activation-Audit):
- Schedule Activation-Audit-Session (1-2 days deep-work).
- Document findings in `decisions_learnings.jsonl`.
- If Onboarding-Flow needs redesign: create Project in `path_state.projects`.

#### If C (Pricing-Axes):
- Open `pricing-axes-doc.md` (Phase C deliverable for 3.4).
- Plan Grandfather-Strategy.
- Update `cash-trough-model.md` mit projected NDR-impact.

#### If D (Champion-Reset):
- Identify At-Risk-Accounts list.
- Assign to CS-Function for Champion-Resell-Plays.
- Track resell-success in next Monthly Review.

#### If E (Segment-Kill):
- Update `channel-portfolio.md` mit Kill-Section.
- Append `decisions_learnings.jsonl`: `{type: "decision", domain: "segment", reasoning: "Killed segment {X}: structural LTV:CAC {Y} below threshold"}`
- Reallocate spend per HubSpot pattern.

### Step 5 — Update path_state

```json
{
  "events": {
    "ndr_below_100": {
      "last_fired_at": "today",
      "last_ndr_value": "{{ndr}}",
      "decision_taken": "A / B / C / D / E",
      "currentSubphase_at_fire": "{{subphase}}"
    }
  },
  "warnings": [...]
}
```

Append `decisions_learnings.jsonl`:

```jsonl
{"type":"decision","date":"YYYY-MM-DD","domain":"retention","reasoning":"NDR-Below-100 event: NDR={{value}}%, chose {A/B/C/D/E}: {1-sentence rationale}"}
```

## Anti-pattern check

Before routing:

- **Single-month dip after-renewal-cycle:** SaaS hat oft seasonal Churn
   am Quarter-End (renewals batched). Wenn NDR < 100% nur 1 Monat +
   matched einer typischen Renewal-Welle: log to `path_state.warnings`
   und wait one more month.
- **Sample-size:** wenn ARR < $1M, NDR-Math ist statistically noisy.
   1-2 große Churns können NDR distorten. Skip event routing unter
   diesem Threshold; surface to user als "NDR-Berechnung statistisch
   unstabil bei dieser Größe".
- **Pricing-Model-Switch:** wenn Pricing kürzlich von Annual auf
   Monthly geändert wurde: NDR-Math ist artificially distorted für
   1-2 Quartale. Recompute on like-for-like.
- **One-Time-Migration-Discount:** wenn Existing-Customer auf neue
   Pricing-Stufe migriert wurden mit Promo-Discount: das ist
   Temporary-Contraction, nicht Churn.

If any check fires: log to `path_state.warnings` mit
`ndr_below_100_noise_filtered` and skip Steps 3-5 for this firing.

## Connection to other operations

- Detected by `monthly-review.md` Section 1 (Cross-KPI Refresh, NDR row)
- Detected by `weekly-checkin.md` Q6 (Step 3.4 specifically)
- Triggers downstream:
  - `channel-portfolio.md` update (Decision E)
  - `cash-trough-model.md` re-projection (Decision A or C)
  - Vector-pause in `vector-decision-doc.md` (Decision A when 3.4)

## Rules

- **Throttle 60 Tage** — Same event re-fires nicht in selbem Quarter
   außer bei single-month sudden shock (> 10pp drop).
- **Anti-pattern check VOR Decision-Routing.** Single-month-noise,
   pricing-model-shifts, low-ARR distort NDR-Reading.
- **Step-aware diagnosis.** Bedeutung von NDR-Drop unterscheidet sich
   zwischen 3.1 (Gate-Status) und 3.4 (Scale-Complete-Condition).
- **Decision-Taken-State written** — next firing weiß was schon
   probiert wurde.
- **No silent passage.** Wenn NDR < 100% für 2 consecutive months:
   eine der Decisions A-E ist mandatory. "Wait and see" ist nicht
   eine valide Option.

## Related files

- `three-gate-dashboard.md` — Gate-3 (NDR > 100%) hier getrackt
- `cross_kpi_log.template.jsonl` — NDR historical readings
- `vector-decision-doc.md` — Vector might dilute Combined NDR (3.4)
- `channel-portfolio.md` — Segment-Kill-Decisions (Decision E)
- `cash-trough-model.md` — Pricing-Axes-Impact
- `knowledge/gtm/matrix/skok-negative-churn.md` — NDR doctrine
- `knowledge/scale/product-line-expansion.md` — Scale-Complete-Condition #3
- `paths/gtm/templates/onboarding-flow.md` — cross-path template for Activation-Audit
- `monthly-review.md` — first detection point
