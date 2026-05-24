---
deliverable_type: activation-metric-doc
status: empty_template
team_required: false
source: matrix_partners_zero_to_100
last_updated: null
version: v1-draft
---

# Activation Metric

> **Status:** empty_template — drafted at start of Step 2.4, locked when validated against ≥1 cohort
> **Team-required:** founder + product + CS lead
> **Source:** Skok's Time-to-Wow + YC's improving-retention + Slack/Dropbox/Figma reference cases

> **STRICT PREDICTIVE RULE.** The activation metric MUST correlate with
> 90-day retention against a real cohort. "Engagement" is not a metric —
> "what % of users do X within 7 days, and does X predict whether they
> stay?" is. Skok: instrument the moment, validate it predicts retention,
> THEN engineer onboarding to produce it.

## How to use this file

A customer who never reaches the product's "Wow moment" will churn no
matter how good your CS team is. The activation metric is the single
moment that says: this customer is now bonded to the product.

You don't get to imagine it. You find it in the data: which behaviors
in week 1 predict 90-day retention? That's your candidate. Validate it
against a cohort. Lock it. Then engineer everything (onboarding,
in-product nudges, CS playbooks) toward producing it as fast as possible.

## Rules (from the substance rubric)

- **metric_is_one (non-negotiable):** ONE primary activation metric.
  Multiple "key actions" = no metric. Pick the single most predictive
  one.
- **metric_measurable_in_product:** instrumented. Not "they seem
  engaged" — a count, a boolean, a threshold.
- **metric_achievable_quickly:** in days or weeks, not months. Skok's
  Time-to-Wow target: <1h SMB, <1Wo Mid-Market, <30d Enterprise.
- **metric_predictive_validated:** correlation with 90-day retention
  measured on a real cohort. Sample ≥30.
- **metric_drives_onboarding:** every onboarding step exists to move
  the customer closer to this metric.

---

## Reference Examples (for inspiration only — pick yours)

| Product | Activation metric | Time-to-Wow |
|---|---|---|
| Slack | 2,000 messages sent within a team | First week |
| Dropbox | 1 file shared with 1 collaborator | First session |
| Figma | 1 design opened by 1 invited viewer | First week |
| Hubspot | 1 contact imported AND 1 email sent through platform | First week |

## Our Activation Metric

<!-- INSTRUCTION: ONE metric, defined precisely. Boolean preferred ("user did X by day Y") over thresholds because it's clearer for ops. -->

- **metric_name:**
- **metric_definition:** <!-- precise, instrumentable. e.g. "user invited ≥1 teammate AND completed first project within 7 days" -->
- **time_window:** <!-- when this must happen — e.g. "within first 7 days of signup" -->
- **why_we_picked_this_one:** <!-- among candidates, why this beats the others -->

## Time-to-Wow Target

- **target_TTW:** <!-- explicit time target -->
- **median_TTW_today:** <!-- current state — ok if "unknown, will measure" at v1-draft -->
- **gap_to_target:**
- **TTW_band_per_segment:** <!-- if it differs by segment, list -->

---

## Predictive Validation

<!-- INSTRUCTION: Activation must predict retention. Compute the lift. -->

- **cohort_used:** <!-- e.g. "Jan-Feb 2026 signups" -->
- **cohort_size:**
- **% who hit activation:**
- **90d_retention_among_activated:**
- **90d_retention_among_NOT_activated:**
- **predictive_lift:** <!-- ratio. >2× lift = strong predictive signal. <1.5× = weak, find a better metric. -->

## Channel-Attributed Activation

<!-- INSTRUCTION: Different channels often produce different activation rates. Bad-fit leads from cheap channels activate worse. -->

| Channel | Customers acquired | % activated | 90d retention | LTV signal |
|---|---|---|---|---|
|   |   |   |   |   |

- **channel_with_lowest_activation:**
- **action_to_take:** <!-- improve channel quality, kill channel, or accept lower LTV -->

---

## Onboarding Engineered to Activate

<!-- INSTRUCTION: Each onboarding step exists to move customer toward activation. Hormozi's Growth Onboarding rule: cut any step that doesn't. -->

| Onboarding step | What it produces | Time required (median) | Drop-off % |
|---|---|---|---|
| Step 1 |   |   |   |
| Step 2 |   |   |   |
| Step 3 |   |   |   |

- **steps_that_could_be_cut:** <!-- friction-removal candidates -->
- **friction_we_already_removed:** <!-- evidence the team is iterating -->

## Salsify-Style Improvements (Skok)

<!-- INSTRUCTION: Skok's Salsify case — 5-step trial → 3-step with auto-scrape = 3× conversion. What can you auto-do for the user? -->

| Manual step today | Auto-version we could ship | Estimated lift |
|---|---|---|
|   |   |   |

---

## At-Risk Account Signals

<!-- INSTRUCTION: When a customer is NOT activating fast enough — what signals trigger CS intervention? -->

| Signal | Threshold | Action |
|---|---|---|
| No login by day X |   |   |
| No team invite by day X |   |   |
| First setup step incomplete |   |   |

- **CSM_alert_owner:**
- **alert_response_time_target:**

## Champion-Departure Watch

<!-- INSTRUCTION: When the champion leaves, the account is at risk. -->

- **champion_field_in_CRM:** <!-- yes/no -->
- **departure_signal_source:** <!-- e.g. "LinkedIn job-change webhook", "no login from champion in 30d" -->
- **re_onboarding_play_for_new_champion:**

---

## Contamination Check

- ONE primary metric named (not a list of "key actions"): <!-- yes/no -->
- Metric is instrumented in product (not vibes): <!-- yes/no -->
- Time-to-Wow under target band (1h/1Wo/30d depending on segment): <!-- yes/no -->
- Predictive lift ≥2× retention vs not-activated: <!-- yes/no -->
- Cohort sample size ≥30: <!-- yes/no -->
- Onboarding steps each move user toward this metric: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial metric candidate selected, Step 2.4 |
| v1-validated | validated | | Predictive lift validated against cohort |
| v1-locked | locked | | Onboarding engineered around the metric |
| v2 | iteration | | Updated when better metric found |

## Related files

- `knowledge/gtm/activation-and-retention.md` — Step 2.4 doctrine
- `knowledge/gtm/matrix/skok-time-to-wow.md` — Salsify case
- `knowledge/gtm/matrix/skok-phase7-customer-success.md` — phase doctrine
- `knowledge/gtm/yc/yc-improving-retention.md` — behavioral signals method
- `knowledge/gtm/hormozi/hormozi-growth-onboarding.md` — onboarding cutting
- `unit-economics-model.md` — LTV depends on activation
