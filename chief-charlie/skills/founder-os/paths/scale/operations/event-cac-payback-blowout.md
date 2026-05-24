# Event — CAC-Payback Blowout

## Trigger

Any one of these (with throttle):

- `three-gate-dashboard.md` shows CAC-Payback > 24 months for 2
  consecutive quarterly readings
- `monthly-review.md` Section 2.1b: Polster (Runway − months-to-Trough-
  Floor) < 6 months
- Channel-CAC of any single channel > 2× target (from `channel-portfolio.md`)
   for 2 consecutive monthly readings
- `path_state.events.cac_payback_blowout.last_fired_at` is NULL OR
   ≥ 60 days ago (throttle — don't re-fire same-quarter)

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.kpis.rows` — current Step 3.1 KPI state
- `path_state.events.cac_payback_blowout` — last-fired metadata
- `path_state.cross_kpis.rule_of_40` — context

Read from logs:
- Last 3 entries `monthly_review_log.template.jsonl`
- `three-gate-dashboard.md` last 3-month readings
- `channel-portfolio.md` current channel-CAC + LTV table
- `cash-trough-model.md` projected Trough-Floor + Polster

## Action

### Step 1 — Notify the founder plainly

> "Signal: CAC-Payback hat {{current_payback}} Monate erreicht
> (Target < 18). Polster zwischen Runway und Trough-Floor:
> {{polster_months}} Monate (Target ≥ 6).
>
> Skok's Diagnose: das ist eines der zwei Patterns, das Scale-Phase
> Companies zum Crash bringt. Wir reagieren JETZT, nicht in 2 Monaten."

### Step 2 — Diagnose: which channel(s) driving the blowout?

Walk through Channel-Portfolio LTV:CAC + Payback per Channel:

```
Channel        CAC    LTV    LTV:CAC    Payback    Status
{channel 1}    ...    ...    ...        ...        red/amber/green
{channel 2}    ...    ...    ...        ...        ...
{channel 3}    ...    ...    ...        ...        ...
```

Identify the **outlier channel(s)** — usually 1-2 channels driving 60%+
of the aggregate blowout. Classify:

- **Channel-Saturation:** CPL rising > 20% w-o-w trotz gleicher
  Targeting? → Channel saturiert.
- **Segment-Drift:** are wir auf Segments mit LTV:CAC < 2 zurückgerutscht?
- **Margin-Decay:** Gross Margin gefallen (Support-Cost gestiegen)?
- **Cash-Up-Front-Shift:** Pricing-Model verschoben (annual → monthly)?

### Step 3 — Decision Path (User picks)

**(A) Slow Hiring + Conserve Cash (Skok-Default during Trough)**

- Freeze pod expansion bis CAC-Payback < 18 Mo wieder.
- Audit hiring-funnel — kill open reqs nicht direkt mission-critical.
- Polster wiederhergestellt: aktive Reqs reaktivieren.

**(B) Kill the Bad Channel + Reallocate**

- Channel mit < LTV:CAC > 3 wird hard-killed.
- Spend reallociert zu Channels mit LTV:CAC ≥ 5 (using HubSpot 12→2 /
   4→25 reallocation pattern).
- Document in `channel-portfolio.md` als Channel-Kill-Entry.

**(C) Price Increase (Hormozi-Pattern — cheapest Unit-Economics fix)**

- Identify under-priced Segments.
- Run grandfather-Test mit neuem Tier auf next 10 deals.
- Wenn close-rate hält: rollout breiter.

**(D) Fundraise jetzt (only if A-C inadequate)**

- TS-Outreach starten, target close 3 Monate vor projected Cash-Floor.
- Update `cash-trough-model.md` Fundraise-Plan-Section.
- Board-Briefing zum Trough vorbereiten.

### Step 4 — Execute the chosen decision

#### If A (Slow Hiring):
- Update `pod-charter.md` per pod: `cloning_decision: paused`
- Update `path_state.warnings`: `{"type": "hiring_paused", "reason": "cac_payback_blowout", "until": "...condition..."}`

#### If B (Kill Channel):
- Update `channel-portfolio.md`: move dead channel to "Killed" section
- Reallocate Spend in `cash-trough-model.md`
- Append `decisions_learnings.jsonl`: `{type: "decision", domain: "channel", reasoning: "Killed {channel}: Payback {X} Mo, LTV:CAC {Y} — reallocated to {alt-channel}"}`

#### If C (Price Increase):
- Document Pricing-Test in `decisions_learnings.jsonl`
- Update `cash-trough-model.md` Section 2 — Segment LTV with new prices
- Watch close-rate impact for next 4 weeks

#### If D (Fundraise):
- Update `cash-trough-model.md` Section Fundraise-Plan
- Set `path_state.warnings` mit `fundraise_outreach_started: today`
- Calendar TS-target, closing-target

### Step 5 — Update path_state

```json
{
  "events": {
    "cac_payback_blowout": {
      "last_fired_at": "today",
      "last_payback_months": "...",
      "decision_taken": "A / B / C / D",
      "outlier_channel": "..."
    }
  },
  "warnings": [...]
}
```

## Anti-pattern check

Before routing to a decision, sanity-check:

- **Sample size:** is the elevated CAC based on ≥ 30 deals per channel?
  If < 30, it's noise — wait one more month before acting.
- **Seasonal effect:** is this a known seasonal trough (Q4 enterprise
  buying patterns, summer slowdown)? Adjust comparison.
- **Pricing-Model-Shift:** has pricing changed (annual → monthly)?
   That artificially expands Payback short-term. Recompute on
   like-for-like.

If any check fires: log to `path_state.warnings` mit
`cac_payback_blowout_noise_filtered` and skip Steps 3-5.

## Connection to other operations

- Detected by `monthly-review.md` Section 2.1b
- Detected by `weekly-checkin.md` Q6 (Step 3.1)
- May trigger downstream:
  - `channel-portfolio.md` update (Decision B)
  - `cash-trough-model.md` refresh (always)
  - Fundraise-Plan (Decision D)

## Rules

- **Throttle 60 Tage** — Same Event re-fires nicht im selben Quarter.
- **Anti-pattern check VOR Decision-Routing.** Noise wird gefiltert.
- **Documented Decision** — Choice A/B/C/D wird gelogged mit Rationale.
- **No silent burn-through.** Wenn Polster < 6 Mo: D ist mandatory
   wenn A-C nicht reichen.
- **Decision-Taken-State written** — next firing weiß, was schon
   probiert wurde.

## Related files

- `three-gate-dashboard.md` — Gate-Status that triggered
- `cash-trough-model.md` — Trough-Floor + Polster math
- `channel-portfolio.md` — Channel-CAC outliers
- `knowledge/gtm/matrix/skok-saas-cash-trough.md` — doctrine
- `knowledge/gtm/hormozi/hormozi-premium-pricing.md` — Pricing-Fix
- `knowledge/gtm/matrix/skok-conserve-cash-until-scaling.md` — Cash-Disziplin
- `monthly-review.md` — first detection point
