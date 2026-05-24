---
deliverable_type: unit-economics-model
status: empty_template
team_required: false
source: matrix_partners_zero_to_100
last_updated: null
version: v1-draft
---

# Unit Economics Model

> **Status:** empty_template — drafted in Step 2.5, refreshed monthly
> **Team-required:** founder + first marketing hire (for channel CAC)
> **Source:** Skok's Phase 8 unit economics + Hormozi's LTGP-vs-CAC + Skok's Rule of 40 + cash-trough framework

> **STRICT THREE-GATE RULE.** All three gates are non-negotiable for
> Phase 3 readiness:
> - LTV:CAC > 3 (computed on LTGP, not LTV)
> - CAC payback < 18 months (< 12 for SMB)
> - Gross margin > 70%
> Failing any one means scaling will burn cash without producing profit.

## How to use this file

This is the gate before "hit the gas" (Phase 3). Skok is explicit: the
single most expensive mistake in the whole roadmap is scaling before
unit economics are proven.

You compute three gates on real cohort data, broken down by channel,
and refresh the model monthly. The job in 2.5 is to either pass all
three or identify exactly which lever to pull (pricing, channel mix,
margin) to pass them in 2 quarters.

## Rules (from the substance rubric)

- **gates_three_explicit (non-negotiable):** LTV:CAC > 3, CAC payback
  < 18mo, gross margin > 70% — all three computed.
- **uses_LTGP_not_LTV:** Lifetime Gross Profit, not Lifetime Revenue.
  Hormozi rule. LTV inflates the ratio by ~30%.
- **channel_level_breakdown:** aggregate CAC hides killer-channels.
  Each channel separately.
- **cohort_validated:** computed on cohorts ≥12 months old where
  possible. < 12 months = directional only.
- **rule_of_40_check:** Growth + Profit margin ≥ 40 for fundability.

---

## The Three Gates

### Gate 1: LTV:CAC > 3 (using LTGP)

| Input | Formula | Value |
|---|---|---|
| Average revenue per account (ARPA) per month |   |   |
| Gross margin |   |   |
| Average customer lifetime (months) |   |   |
| **LTGP = ARPA × Margin × Lifetime** |   |   |
| Average CAC |   |   |
| **LTGP : CAC ratio** |   |   |

- **gate_1_status:** <!-- pass / fail / borderline -->
- **gate_1_evidence_cohort:** <!-- which cohort window this is computed on -->

### Gate 2: CAC Payback < 18 months

| Input | Value |
|---|---|
| ARPA per month |   |
| Gross margin |   |
| Monthly gross profit per customer (ARPA × Margin) |   |
| CAC |   |
| **Payback months = CAC ÷ Monthly Gross Profit** |   |

- **target_band:** <!-- < 12 SMB, < 18 B2B, < 6 excellent -->
- **gate_2_status:** <!-- pass / fail / borderline -->

### Gate 3: Gross Margin > 70%

| Cost-of-revenue component | Annualized cost | % of revenue |
|---|---|---|
| Hosting / infrastructure |   |   |
| Customer-facing support headcount |   |   |
| Third-party APIs |   |   |
| Payment processing |   |   |
| Other (specify) |   |   |
| **Total COGS** |   |   |
| **Gross margin** |   |   |

- **gate_3_status:** <!-- pass / fail / borderline -->

---

## Channel-Level Economics

<!-- INSTRUCTION: Aggregate CAC hides killer-channels. Compute each channel separately. Profitable Channels by LTV:CAC, NOT by CAC alone. -->

| Channel | Customers acquired (12mo) | Channel spend + sales effort | CAC | ARPA | Retention rate | LTGP | LTGP:CAC | Decision |
|---|---|---|---|---|---|---|---|---|
| Channel 1 |   |   |   |   |   |   |   |   |
| Channel 2 |   |   |   |   |   |   |   |   |
| Channel 3 |   |   |   |   |   |   |   |   |

- **best_channel_by_LTGP_CAC:**
- **worst_channel_by_LTGP_CAC:**
- **channel_to_kill_or_fix:**

## Channel-Level Retention (Cross-Reference 2.4)

<!-- INSTRUCTION: Channels with high CAC + low retention are the killer combo. -->

| Channel | 12mo logo retention | 12mo NDR | Notes |
|---|---|---|---|
|   |   |   |   |

---

## Profitability Levers (When a Gate Fails)

### Lever 1: Pricing (Hormozi: cheapest fix)

- **current_headline_price:**
- **competitor_or_anchor_price:**
- **premium_pricing_test_planned:** <!-- yes/no — small price-increase test on new logos -->
- **expected_LTGP_lift:**

### Lever 2: Channel Mix

- **channel_to_double_down_on:**
- **channel_to_de-emphasize:**
- **expected_blended_CAC_change:**

### Lever 3: Margin (Infrastructure / Support)

- **support_load_ratio:** <!-- support hours per customer per month -->
- **self_serve_migration_candidate:**
- **infra_cost_optimization:** <!-- caching, tiered storage, etc. -->

### Lever 4: Retention (back to 2.4)

- **activation_rate:** <!-- from activation-metric-doc.md -->
- **NDR:** <!-- target >100% -->
- **expansion_pricing_axis_active:** <!-- seats/usage/editions -->

---

## Cash-Flow Trough Model

<!-- INSTRUCTION: Skok's framework. SaaS cash-trough deepens with growth. Show that growth is healthy investment, not bleeding. -->

| Month | New customers | New CAC outflow | Recurring gross profit inflow | Net monthly cash | Cumulative cash |
|---|---|---|---|---|---|
|   |   |   |   |   |   |

- **deepest_trough_month:**
- **trough_depth_dollars:**
- **breakeven_month:**
- **runway_covers_trough:** <!-- yes/no -->
- **financing_in_place_if_no:**

## Rule of 40

| Metric | Value |
|---|---|
| YoY revenue growth rate (%) |   |
| Operating margin (%) |   |
| **Rule of 40 score = Growth + Margin** |   |
| Pass / Fail |   |

- **path_to_40_if_failing:**

## Bookings vs ARR Tracking

| Month | Net New ARR (bookings) | Cumulative ARR | Bookings M-o-M trend |
|---|---|---|---|
|   |   |   |   |

- **bookings_flat_warning:** <!-- if bookings flat for 2 months, flag -->

---

## Stage-Appropriate Metrics Check (Skok)

<!-- INSTRUCTION: Don't obsess over CAC at $100K ARR. -->

- **current_ARR:**
- **stage_we_are_in:** <!-- PMF (Phase 1) / Repeatable (2.1-2.3) / Profitable (2.5+) -->
- **metrics_we_should_track_at_this_stage:** <!-- match metrics to stage -->
- **metrics_we_can_safely_de-prioritize:**

## Contamination Check

- LTGP used (not LTV / Lifetime Revenue): <!-- yes/no -->
- All 3 gates computed (LTGP:CAC, payback, margin): <!-- yes/no -->
- Channel-level breakdown done (not aggregate only): <!-- yes/no -->
- Cohort window ≥12 months OR explicitly flagged as directional: <!-- yes/no -->
- Cash-trough modeled, runway covers it OR financing is in place: <!-- yes/no -->
- Rule of 40 ≥ 40 OR clear 2-quarter path documented: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial model drafted, Step 2.5 |
| v1-monthly | rolling | | Refreshed each month |
| v1-pass-all-gates | gates-passed | | All 3 gates passing — Phase 3 unlocked |

## Related files

- `bookings-plan.md` — bookings target this model gates
- `marketing-sales-contract.md` — channel CAC inputs
- `activation-metric-doc.md` — retention input to LTGP
- `knowledge/gtm/unit-economics.md` — Step 2.5 doctrine
- `knowledge/gtm/matrix/skok-phase8-unit-economics.md` — three gates
- `knowledge/gtm/matrix/skok-rule-of-40.md` — fundability check
- `knowledge/gtm/matrix/skok-saas-cash-trough.md` — trough framework
- `knowledge/gtm/hormozi/hormozi-ltgp-vs-cac.md` — LTGP discipline
- `knowledge/gtm/hormozi/hormozi-premium-pricing.md` — pricing lever
- `knowledge/gtm/hormozi/hormozi-client-financed-acquisition.md` — eliminate trough
