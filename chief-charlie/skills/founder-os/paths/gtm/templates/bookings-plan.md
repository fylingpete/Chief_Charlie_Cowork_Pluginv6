---
deliverable_type: bookings-plan
status: empty_template
team_required: false
source: matrix_partners_zero_to_100
last_updated: null
version: v1-draft
---

# Bookings Plan — Reps × PPR

> **Status:** empty_template — drafted in Step 2.3, updated quarterly
> **Team-required:** yes — sales lead + first marketing hire + founder
> **Source:** Skok's Phase 6 bookings-math + Schatz's pipeline forecasting + bookings-not-arr

> **STRICT FORMULA RULE.** Bookings = #Reps × Productivity-per-Rep
> (PPR). Both levers must be modeled with realistic ramp curves. Linear
> projections of headcount without lead-supply gating produce paper plans
> that fall apart in execution. Skok: *"the bookings plan is only as good
> as the lead plan."*

## How to use this file

The bookings plan is the operating math for 2.3 onward. It says how many
new bookings you commit to each quarter, and what has to be true (rep
hires, lead supply, ramp curves) for that number to be real.

Two failure modes if you skip the discipline:
1. Linear sales-hiring with saturating lead-supply → reps idle, PPR collapses
2. Watching ARR (lagging indicator) instead of bookings (leading indicator)
   → flatline hidden for 6+ months

## Rules (from the substance rubric)

- **bookings_formula_explicit (non-negotiable):** plan shows
  Bookings = #Reps × PPR with both inputs modeled.
- **bookings_ramped_not_linear:** new reps modeled with 3-6 month ramp
  curves, not full quota from month 1.
- **bookings_gated_by_leads:** plan references lead-supply forecast and
  shows the contract (cohort math) holds.
- **bookings_monthly_not_arr:** primary metric is monthly bookings, not
  ARR. ARR is shown as derived for context only.
- **bookings_has_pipeline_coverage:** target pipeline coverage 3-4× quota.

---

## Headline Plan

| Quarter | New ARR target | Expansion target | Churn allowance | Net New ARR (bookings) |
|---|---|---|---|---|
| Q1 |   |   |   |   |
| Q2 |   |   |   |   |
| Q3 |   |   |   |   |
| Q4 |   |   |   |   |

- **annual_net_new_arr_target:**
- **growth_rate_implied:**
- **rule_of_40_check:** <!-- growth + profit margin = ? Reference unit-economics-model.md -->

## Rep Capacity Model

<!-- INSTRUCTION: List every rep with hire date, ramp window, and target post-ramp PPR. -->

| Rep ID / Name | Hire date | Ramp end (3-6 mo) | Target PPR (annual) | Pod assignment |
|---|---|---|---|---|
|   |   |   |   |   |

- **total_reps_at_quarter_end_q1:**
- **total_reps_at_quarter_end_q4:**
- **average_ramp_months:**
- **OTE_average:** <!-- so we can sanity-check >4× OTE bar -->

## Productivity Per Rep (PPR)

<!-- INSTRUCTION: Realistic PPR by tenure. Ramp PPR < Mature PPR. -->

| Tenure | Expected PPR (% of mature) | Mature PPR ($) |
|---|---|---|
| Month 1-2 | 0-10% |   |
| Month 3-4 | 25-50% |   |
| Month 5-6 | 50-80% |   |
| Month 7+ | 100% (mature) |   |

- **mature_PPR_target_annual:**
- **mature_PPR_evidence:** <!-- reference: which rep already hits this in 2.2? -->

---

## Lead-Supply Forecast (Marketing-Sales Contract)

<!-- INSTRUCTION: Cohort-based reverse engineering. From bookings target back to leads needed. -->

| Funnel stage | Conversion to next | Volume needed for Q1 | Volume needed for Q4 |
|---|---|---|---|
| Leads (top of funnel) |   |   |   |
| MQLs |   |   |   |
| SQLs |   |   |   |
| Opportunities |   |   |   |
| Closed-won |   |   |   |

- **conversion_rates_validated_against_cohorts:** <!-- yes/no — must be cohort, not snapshot -->
- **cohort_window_used:** <!-- e.g. "Jan 2025 cohort tracked through Sep 2025" -->

## Lead-Source Mix

<!-- INSTRUCTION: ≥2 sources with >20% share. Skok's no-single-channel-dependence rule. -->

| Channel | Share of leads | Lead volume per Mo | CAC per channel | LTV per channel | LTV:CAC |
|---|---|---|---|---|---|
| Channel 1 |   |   |   |   |   |
| Channel 2 |   |   |   |   |   |
| Channel 3 (planned) |   |   |   |   |   |

- **single_channel_dependence_check:** <!-- top channel <60% of total -->
- **next_channel_to_layer:**
- **next_channel_start_date:**

---

## Pipeline Coverage & Velocity

<!-- INSTRUCTION: Schatz's discipline. Updated weekly. -->

- **target_pipeline_coverage:** <!-- 3-4× quota -->
- **current_pipeline_coverage:**
- **pipeline_velocity:** <!-- (deals × win rate × deal size) ÷ cycle time -->
- **velocity_trend_woW:**

## Pipeline Health Signals

| Signal | Healthy threshold | Current | Status |
|---|---|---|---|
| Pipeline coverage |   |   |   |
| Avg cycle time |   |   |   |
| Win rate |   |   |   |
| Avg deal size |   |   |   |

---

## Pod Plan

<!-- INSTRUCTION: Skok + Kazanjy revenue mitochondria. SDR + 2-3 AEs + CSM = pod. Don't add pod #2 until pod #1 hits quota for 2 quarters. -->

| Pod | SDRs | AEs | CSMs | At quota since (date) | Cohort acquired |
|---|---|---|---|---|---|
| Pod 1 |   |   |   |   |   |
| Pod 2 |   |   |   |   |   |

- **pod_2_clone_trigger_met:** <!-- yes/no — has pod 1 been at quota for 2 quarters? -->

---

## Risks & Watchpoints

<!-- INSTRUCTION: What kills this plan? Lead saturation, rep ramp slippage, churn spike, channel CAC drift. Track each. -->

| Risk | Trigger to act | Action if triggered |
|---|---|---|
|   |   |   |

## Bookings vs ARR Tracking

<!-- INSTRUCTION: Bookings monthly, ARR quarterly. Bookings is leading indicator — flat bookings → flat ARR in 6 months. -->

| Month | Net New ARR (bookings) | Cumulative ARR | Bookings trend M-o-M |
|---|---|---|---|
|   |   |   |   |

## Contamination Check

- Bookings = #Reps × PPR with both inputs modeled: <!-- yes/no -->
- Reps modeled with 3-6 month ramp (not full quota Mo 1): <!-- yes/no -->
- Lead-supply contract validated against cohort math: <!-- yes/no -->
- ≥2 channels each >20% share (no single-channel-dependence): <!-- yes/no -->
- Pipeline coverage tracked weekly at 3-4×: <!-- yes/no -->
- Bookings tracked monthly, not just ARR: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial bookings plan drafted at start of Step 2.3 |
| v1-locked | locked | | Locked when ≥2 lead sources >20% AND ≥2 pods at quota |
| v2 | quarterly-update | | Updated each quarter |

## Related files

- `marketing-sales-contract.md` — cohort math behind lead numbers
- `unit-economics-model.md` — LTV:CAC behind channel choices
- `sales-playbook.md` — what reps actually execute
- `knowledge/gtm/scale-demand-and-sales.md` — Step 2.3 doctrine
- `knowledge/gtm/matrix/skok-phase6-bookings-math.md` — formula source
- `knowledge/gtm/matrix/skok-phase6-scalable-lead-sources.md` — channel layering
- `knowledge/gtm/matrix/skok-bookings-not-arr.md` — leading-indicator rule
- `knowledge/gtm/matrix/schatz-pipeline-forecasting.md` — pipeline discipline
