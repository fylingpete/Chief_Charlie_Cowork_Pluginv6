---
deliverable_type: marketing-sales-contract
status: empty_template
team_required: true
source: matrix_partners_zero_to_100
last_updated: null
version: v1-draft
---

# Marketing-Sales Contract

> **Status:** empty_template — drafted in Step 2.3 once first marketing hire is in place
> **Team-required:** YES — sales lead AND marketing lead must both sign off
> **Source:** Skok's cohort-funnel-analysis + Schatz's pipeline forecasting

> **STRICT COHORT RULE.** Conversion rates in this document MUST be
> cohort-based, NOT snapshot. Snapshots lie because each lead takes weeks
> to traverse the funnel. Track each January cohort through 1, 2, 3, 6
> months. Skok: *"funnel conversion rates require cohort analysis."*

## How to use this file

In 2.3 you have a marketing function and a sales function. They need to
agree, in writing, on what each one delivers. Without this contract,
sales blames marketing for "bad leads", marketing blames sales for "not
following up", and both are right while neither has a fixable problem.

The contract is built backwards: start from the bookings target, divide
by each conversion rate stage by stage to land at the leads target.
Both sides commit to their stage. When numbers miss, the side that owns
the gap fixes it (or escalates with data, not vibes).

## Rules (from the substance rubric)

- **contract_cohort_based (non-negotiable):** every conversion rate is
  computed on cohorts (e.g. Jan 2025 leads tracked through Sep 2025),
  not snapshot.
- **contract_reverse_engineered:** math runs backwards from bookings to
  leads, not forwards.
- **contract_signed_by_both:** sales lead AND marketing lead both
  signed off — names + dates.
- **contract_has_review_cadence:** monthly review with both sides
  in the room.
- **contract_has_escalation_path:** when a number misses, defined
  process for who fixes what.

---

## Bookings Target → Leads Required (Reverse Engineering)

<!-- INSTRUCTION: Skok's example as guide. Substitute your own numbers. -->

```
{N closes per quarter} target
  ÷ {close rate from SQL}
= {SQLs needed}
  ÷ {SQL rate from MQL}
= {MQLs needed}
  ÷ {MQL rate from raw lead}
= {leads needed}
```

| Stage | Volume needed Q1 | Volume needed Q4 | Conversion to next | Cohort source for rate |
|---|---|---|---|---|
| Leads (raw) |   |   |   |   |
| MQLs |   |   |   |   |
| SQLs |   |   |   |   |
| Opportunities |   |   |   |   |
| Closed-won |   |   |   |   |

## Cohort Conversion Rates

<!-- INSTRUCTION: Each rate validated against a real cohort window. List the cohort. -->

| Stage transition | Conversion rate | Validated against cohort | Cohort window | Sample size |
|---|---|---|---|---|
| Lead → MQL |   |   |   |   |
| MQL → SQL |   |   |   |   |
| SQL → Opp |   |   |   |   |
| Opp → Closed-won |   |   |   |   |

- **all_rates_cohort_validated:** <!-- yes/no — non-negotiable -->
- **smallest_sample_size:** <!-- if any sample <30, flag as directional only -->

---

## Lead Quality Definition

<!-- INSTRUCTION: What makes a lead "qualified" — both sides must agree on the same definition. -->

### MQL Definition (Marketing's bar to hand to Sales)

- **fit_criteria_required:** <!-- ICP-positive characteristics from icp-doc.md -->
- **disqualifiers_marketing_filters_out:** <!-- ICP-negative characteristics from icp-doc.md -->
- **engagement_threshold_required:** <!-- e.g. "downloaded X resource AND visited pricing page" -->

### SQL Definition (Sales' bar to accept)

- **discovery_call_completed:** <!-- yes -->
- **fit_confirmed_by_rep:**
- **buyer_authority_or_path_to_authority:**
- **timing_signal:**
- **rejection_reasons_sales_will_send_back:** <!-- "wrong size", "no budget", etc. -->

## Disqualification Loop

<!-- INSTRUCTION: When sales rejects an MQL, marketing learns. Without this loop, both sides argue forever. -->

- **rejection_returns_to_marketing_within:** <!-- 24-48h -->
- **rejection_categorized_for_pattern_detection:** <!-- yes -->
- **monthly_rejection_review_owner:** <!-- name -->

---

## Volume Commitments

<!-- INSTRUCTION: Each side commits to a number. -->

### Marketing commits to deliver

- **leads per month:**
- **MQLs per month:**
- **MQL→SQL rate threshold:** <!-- e.g. ≥30% -->

### Sales commits to deliver

- **SQL response time:** <!-- e.g. <24h from MQL handoff -->
- **SQL→Opp conversion rate:** <!-- e.g. ≥50% -->
- **Opp→Close rate:** <!-- e.g. ≥25% -->
- **No-show rate ceiling:** <!-- e.g. ≤30% -->

---

## Escalation Path

<!-- INSTRUCTION: When a number misses 2 months in a row, what happens? -->

| Number that missed | Owner of the gap | First action | Escalation if not fixed |
|---|---|---|---|
|   |   |   |   |

## Review Cadence

- **monthly_review_date:** <!-- e.g. "first Wednesday of each month" -->
- **monthly_review_attendees:** <!-- both sides plus founder -->
- **agenda_template:** <!-- last month's actuals vs commitments, gap analysis, next-month adjustments -->

---

## Sign-Off

| Role | Name | Date | Signature / acknowledgement |
|---|---|---|---|
| Sales lead |   |   |   |
| Marketing lead |   |   |   |
| Founder / CEO |   |   |   |

## Contamination Check

- All conversion rates from real cohorts (not snapshots): <!-- yes/no -->
- Math runs backwards from bookings to leads: <!-- yes/no -->
- Both sides signed off with names + dates: <!-- yes/no -->
- Monthly review on the calendar: <!-- yes/no -->
- Disqualification loop closes within 48h: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial contract drafted in Step 2.3 |
| v1-signed | active | | Both sides signed |
| v2 | quarterly-update | | Updated each quarter as cohorts mature |

## Related files

- `bookings-plan.md` — sales side of the contract
- `icp-doc.md` — fit criteria for both sides
- `unit-economics-model.md` — channel CAC by lead source
- `knowledge/gtm/scale-demand-and-sales.md` — Step 2.3 doctrine
- `knowledge/gtm/matrix/skok-cohort-analysis-funnel.md` — cohort method
- `knowledge/gtm/matrix/schatz-pipeline-forecasting.md` — pipeline rhythm
