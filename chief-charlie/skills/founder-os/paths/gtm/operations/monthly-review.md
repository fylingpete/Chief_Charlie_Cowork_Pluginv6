# GTM Monthly Review

60 minutes. Run once per month. Produces a measured snapshot of the
current step's KPIs, refreshes `path_state.kpis.rows`, fires events
when thresholds are crossed.

## When to run this

- `path_state.cadences.last_monthly_at` is ≥28 days ago
- User explicitly requests "monthly review" or "monthly review"
- After a `phase-change.md` to establish a baseline at the new step
- Before a `quarterly-rebuild.md` (which depends on monthly numbers)

## Pre-flight

Read from `dashboard_data.json`:

- `path_state.roadmap.currentSubphase` — determines which metrics to measure
- `path_state.kpis.rows` — current state to compare against
- `path_state.cadences.last_monthly_at` — for delta computation
- Latest entries from `decisions_learnings.jsonl` since
  `last_monthly_at` — for context on what changed

Read from step-specific data sources (depending on `currentSubphase`):

- 2.1: `channel-test.md` weekly logs, `icp-doc.md` repeat-win counter,
  `sales-playbook.md` stage conversions
- 2.2: rep PPR data, call-recording reviews, `objection-map.md` updates
- 2.3: `bookings-plan.md` actuals, `marketing-sales-contract.md`
  cohort math, lead-source mix
- 2.4: cohort retention from logs, `activation-metric-doc.md` cohort
  performance, `onboarding-flow.md` TTW measurement
- 2.5: `unit-economics-model.md` three-gate computation, channel-level
  CAC/LTV refresh

## Step-Specific Measurement

The intro is the same; the metric set depends on `currentSubphase`.

---

### Step 2.1 — Find a repeatable sales motion

**Greeting:**

> "Monthly Review für Step 2.1 — wir messen, ob die Sales-Motion
> wiederholbar wird."

**Metrics to capture:**

1. **Buyer-Conversations diesen Monat** (Kazanjy: 50-150 total Ziel)
   - Total this month: ___
   - Cumulative since 2.1 start: ___
   - Per week average: ___ (Skok-Ziel: 15-20)

2. **Channel-Test Status** (`channel-test.md`)
   - Weeks running: ___
   - Total volume sent / spent: ___
   - Reply rate / response rate: ___ %
   - Discovery calls booked: ___
   - Closed-won via channel: ___
   - Vs. kill criteria: on track / at risk / failed

3. **Sales-Playbook Conversion Rates**
   - Lead → Discovery: ___ %
   - Discovery → Demo: ___ %
   - Demo → Close: ___ %
   - Compared to last month: trending up/flat/down

4. **Repeat-Win Counter** (`icp-doc.md` Repeat-Win Validation)
   - Wins via same playbook this month: ___
   - Cumulative repeat wins: ___
   - Distance to 2.1 exit (≥2): ___

5. **ICP Match Quality**
   - Closed-won that fit ICP cleanly: ___
   - Closed-won that fit ICP partially: ___
   - Lost deals where ICP-mismatch was clear: ___

**Findings to log:**

- If reply rate dropped > 30% vs last month → flag for
  `event-conversion-drop.md` review
- If channel-test passed kill criteria → flag for
  `event-channel-failed.md`
- If repeat-win counter hit ≥2 → ICP/messaging/playbook ready for v1-lock
  (next session: `playbook-update.md` to flip status)

---

### Step 2.2 — Prove non-founders can sell

**Greeting:**

> "Monthly Review für Step 2.2 — wir messen, ob deine Reps wirklich
> ohne dich verkaufen können."

**Metrics to capture:**

1. **Rep Productivity (per Rep)**
   - Rep 1 PPR this month: ___ (% of mature target)
   - Rep 2 PPR this month: ___ (% of mature target)
   - >4× OTE check: ___

2. **Founder-Off-Closing-Seat Days**
   - Days founder NOT on rep-led calls this month: ___
   - Cumulative: ___ (target ≥30)

3. **Customer Happiness Parity**
   - CSAT/NPS for rep-led deals this month: ___
   - CSAT/NPS for founder-led deals (baseline): ___
   - Parity check (within 10%): yes / no

4. **Coaching Cadence**
   - Call recordings reviewed per rep this month: ___
   - Schatz black-sheet rubric applied: yes / no
   - Major coaching findings (3-5):
     - ___
     - ___
     - ___

5. **Objection-Map Stability**
   - New objections added this month: ___
   - Objections removed (no longer happening): ___
   - Map stable for ≥30 days: yes / no

**Findings to log:**

- If both reps < 2× OTE post-ramp → playbook is broken, route to
  `playbook-update.md` for `sales-playbook.md`
- If founder still on every call → loop coaching, not the rep itself
- If new objections > removed → messaging may need adjustment, route to
  `messaging-adjustment.md`

---

### Step 2.3 — Make growth scalable

**Greeting:**

> "Monthly Review für Step 2.3 — wir messen Demand-Gen-Skalierung und
> Sales-Capacity."

**Metrics to capture:**

1. **Bookings (Net New ARR / Mo)**
   - This month: ___
   - 3-month rolling avg: ___
   - YoY: ___ %
   - Bookings-flat-warning: yes if 2 months flat → flag

2. **Lead-Source Mix**
   - Channel 1: ___ leads, ___ % of total
   - Channel 2: ___ leads, ___ % of total
   - Channel 3 (planned): status
   - Single-channel-dependence check (top channel < 60%): yes / no

3. **Pipeline Coverage & Velocity**
   - Pipeline coverage (pipeline value ÷ quota): ___ × (target 3-4×)
   - Pipeline velocity ($/cycle-time): ___
   - W-o-W trend: up / flat / down

4. **Channel-Level CAC**
   - Channel 1 CAC this month: $___
   - Channel 2 CAC this month: $___
   - Any channel CAC > 2× target: yes / no → flag

5. **Pod Performance**
   - Pod 1 attainment: ___ % of quota
   - Pod 2 attainment (if present): ___
   - Pods at quota for ≥2 quarters: ___

6. **Marketing-Sales Contract Adherence**
   - Marketing leads delivered vs commit: ___ %
   - Sales SQL→Opp rate vs commit: ___ %
   - Disqualification loop closed within 48h: yes / no

**Findings to log:**

- If bookings flat 2 months → flag `event-conversion-drop.md`
- If pipeline coverage < 3× → marketing must add leads or sales must
  compress cycle time
- If channel CAC > 2× target → flag in `path_state.warnings`,
  surface in `unit-economics-model.md` review

---

### Step 2.4 — Ensure customers succeed

**Greeting:**

> "Monthly Review für Step 2.4 — wir messen Activation und Retention
> auf Cohort-Basis."

**Metrics to capture:**

1. **Activation Rate (this month's cohort)**
   - Customers acquired this month: ___
   - % activated within target window: ___
   - Predictive lift (activated vs not, 90d retention): ___ ×

2. **Time-to-Wow (this month's cohort)**
   - Median TTW: ___ (target band: <1h SMB / <1Wo Mid / <30d Ent)
   - p90 TTW: ___
   - Adherence to promise: ___ %

3. **Logo Retention by Cohort**
   - 12-month retention for cohort acquired 12 months ago: ___ % (target >85%)
   - 6-month retention for cohort acquired 6 months ago: ___ %
   - 3-month retention for cohort acquired 3 months ago: ___ %

4. **Net Dollar Retention (NDR)**
   - This month's NDR: ___ % (target >100%)
   - 3-month rolling: ___ %
   - Negative-churn achieved (NDR > 100%): yes / no

5. **Channel-Attributed Retention**
   - Channel 1 retention: ___ %
   - Channel 2 retention: ___ %
   - Worst channel retention: ___ % → action

6. **Churn Reasons (from `churn_reason_log.jsonl`)**
   - Churns this month: ___
   - Top reason: ___
   - Root cause classification (ICP / sales-promise / activation /
     product / champion-departure / external):

**Findings to log:**

- If 12mo retention < 85% → flag `event-churn-spike.md`
- If NDR < 100% → review pricing axes in
  `activation-metric-doc.md`
- If churn root cause is ICP/sales-promise → upstream fix, route to
  `icp-adjustment.md` or `playbook-update.md`

---

### Step 2.5 — Make it profitable

**Greeting:**

> "Monthly Review für Step 2.5 — wir refresh die Unit Economics gegen
> die drei Skok-Gates."

**Metrics to capture:**

1. **Three Gates** (`unit-economics-model.md`)
   - LTGP:CAC ratio: ___ (target >3, computed on cohort ≥12mo)
   - CAC Payback months: ___ (target <18 / <12 SMB)
   - Gross Margin: ___ % (target >70%)
   - Gates passing: ___ of 3

2. **Channel-Level Economics**
   - Best channel by LTGP:CAC: ___
   - Worst channel by LTGP:CAC: ___
   - Any channel with LTGP:CAC < 1: yes / no → kill candidate

3. **Cash-Trough Position**
   - Months of runway covering trough: ___
   - Trough-depth vs runway: ___ % of runway used
   - Financing in place if needed: yes / no

4. **Rule of 40**
   - Growth rate (YoY): ___ %
   - Operating margin: ___ %
   - Sum: ___ (target ≥40)

5. **Bookings (Phase 2 carry-over)**
   - Net New ARR / Mo: ___
   - vs target: ___ %

**Findings to log:**

- If all 3 gates pass + Rule of 40 ≥ 40 → flag
  `event-2.5-milestone.md` (Phase 3 switch candidate)
- If any gate fails → identify lever (pricing / channel / margin /
  retention) and route to `unit-economics-model.md` update via
  `playbook-update.md`
- If channel LTGP:CAC < 1 → kill-channel decision in next quarterly

---

## Wrap (every step)

### Update `path_state.kpis.rows`

Overwrite `current` values with measured numbers from this session.
Update `status` (`red` / `amber` / `green`) per row based on:

- `red`: > 50% gap to target
- `amber`: 10-50% gap
- `green`: at or above target

### Update cadence

```
path_state.cadences.last_monthly_at = today
path_state.cadences.next_monthly_due = today + 30 days
```

### Append to `monthly_review_log.jsonl`

```jsonl
{"date":"YYYY-MM-DD","subphase":"{currentSubphase}","metrics":{...},"flags":["event-channel-failed",...]}
```

### Fire any flagged events

If any of these flags are set in this measurement, surface them in the
user's next session by adding to `path_state.events_pending`:

- `event-channel-failed`
- `event-conversion-drop`
- `event-churn-spike`
- `event-2.5-milestone`

The events themselves are separate operations and run when the user
re-engages.

### Confirm to user

> "Monthly logged. Status der KPIs aktualisiert. {N} Findings im
> `decisions_learnings.jsonl`. {M} Events sind für die nächste Session
> markiert."

## Knowledge references

The metrics and thresholds in this operation derive from the step-level
knowledge files:

- `knowledge/gtm/repeatable-sales-motion.md` — Step 2.1 metrics
- `knowledge/gtm/founder-to-rep-handoff.md` — Step 2.2 metrics
- `knowledge/gtm/scale-demand-and-sales.md` — Step 2.3 metrics
- `knowledge/gtm/activation-and-retention.md` — Step 2.4 metrics
- `knowledge/gtm/unit-economics.md` — Step 2.5 metrics
- `knowledge/gtm/matrix/skok-stage-appropriate-metrics.md` — why each
  metric belongs to its stage

## Rules

- **60 minutes is the budget.** This is a measurement session, not a
  rebuild. Don't deep-dive into a single number — log it and surface.
- **Numbers come from data, not gut.** If a number isn't measurable
  yet (no instrumentation), record `n/a` and add an instrumentation
  task.
- **Cohort-based numbers preferred over snapshots** — especially for
  retention and conversion rates.
- **Cross-step trackers preserved** — when transitioning to next step
  via phase-change, Bookings (2.2-2.3) and Retention (2.4-2.5) values
  carry forward.
