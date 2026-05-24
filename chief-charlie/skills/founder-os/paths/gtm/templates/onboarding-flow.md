---
deliverable_type: onboarding-flow
status: empty_template
team_required: false
source: matrix_partners_zero_to_100
last_updated: null
version: v1-draft
---

# Onboarding Flow

> **Status:** empty_template — drafted in Step 2.4 alongside activation-metric-doc
> **Team-required:** founder + first CSM (or founder acting as CSM)
> **Source:** Hormozi's Growth Onboarding + Skok's Time-to-Wow + YC's improving-retention

> **STRICT VALUE-DELIVERY RULE.** Every step in onboarding exists to move
> the customer toward the activation metric. If a step doesn't, cut it.
> Skok's Salsify case: 5-step → 3-step with auto-scrape = 3× conversion.

## How to use this file

The onboarding flow is what happens between "contract signed" and
"customer is activated, retained, and expanding." It's the bridge
between sales and steady-state CS. Get it wrong and your activation
metric never moves.

You write this BACKWARDS from the activation metric:
1. Activation metric is X (from activation-metric-doc.md)
2. To produce X, customer needs Y, Z, W
3. Onboarding flow = the shortest path through Y, Z, W

## Rules (from the substance rubric)

- **flow_engineered_for_activation (non-negotiable):** every step
  references which prerequisite for activation it produces.
- **flow_time_boxed:** explicit "you'll be live in X days" promise.
  Track adherence.
- **flow_minimized_friction:** form fields, required calls, approval
  gates — each one is a drop-off. Justified or removed.
- **flow_owner_named:** ONE named person per customer, not "the team".
- **flow_handoff_trigger_explicit:** when does customer "graduate"
  from onboarding to steady-state CS?

---

## The Flow (End-to-End)

<!-- INSTRUCTION: Each step is one row. Time, owner, output, drop-off rate. -->

| Step | What happens | Owner | Customer time required | Median elapsed time | Drop-off % | Activation prerequisite produced |
|---|---|---|---|---|---|---|
| Kickoff |   |   |   |   |   |   |
| Setup |   |   |   |   |   |   |
| First value moment |   |   |   |   |   |   |
| Team expansion |   |   |   |   |   |   |
| Graduation to CS |   |   |   |   |   |   |

## Time-to-Wow Promise

- **promised_TTW:** <!-- explicit promise made at sale -->
- **measured_TTW_median:**
- **measured_TTW_p90:** <!-- 90th percentile — long-tail -->
- **adherence_to_promise:** <!-- % hitting promised TTW -->

---

## Friction Audit

<!-- INSTRUCTION: List every friction point. Decide: remove, reduce, or justify. -->

| Friction | Where it occurs | Drop-off % at this point | Decision (remove/reduce/justify) | Plan |
|---|---|---|---|---|
|   |   |   |   |   |

## Salsify-Style Auto-Versions

<!-- INSTRUCTION: For each manual step, ask: can we auto-do this? Skok's case study: auto-scrape data instead of manual import. -->

| Manual step today | Auto-version | Estimated TTW reduction | Build cost |
|---|---|---|---|
|   |   |   |   |

---

## Handoff to Steady-State CS

<!-- INSTRUCTION: When does the customer "graduate"? Without this, onboarding never ends OR happens too quickly. -->

- **graduation_trigger:** <!-- e.g. "activation metric achieved AND first 30 days complete AND no open tickets" -->
- **graduation_artifacts_handed_over:** <!-- account notes, expansion signals, champion identification -->
- **steady_state_CSM_assigned:**
- **first_QBR_scheduled_within:** <!-- e.g. "60 days post-graduation" -->

## Sales-to-Onboarding Handoff (Inputs)

<!-- INSTRUCTION: What MUST the sales rep deliver before onboarding starts? Tied to sales-playbook.md handoff section. -->

- **mandatory_fields_at_kickoff:**
  - Champion name + role:
  - Promised timeline to value:
  - Expected use case:
  - Things sales committed to in writing:
  - Things sales committed to verbally that we should know:
- **kickoff_call_within:** <!-- e.g. 5 business days of contract signed -->
- **what_blocks_kickoff:** <!-- e.g. "no champion identified", "missing technical contact" -->

---

## Customer-Side Risks

<!-- INSTRUCTION: Things customer must do that they often don't. CSM owns surfacing these early. -->

| Customer-side risk | Early signal | CSM action |
|---|---|---|
|   |   |   |

## Champion Identification

<!-- INSTRUCTION: Skok / Hormozi: account is at risk when champion leaves. Track from day 1. -->

- **primary_champion:** <!-- name + role -->
- **secondary_champion:** <!-- backup if #1 leaves -->
- **executive_sponsor:**
- **champion_change_alert_path:**

---

## Cohort Performance

<!-- INSTRUCTION: Track each onboarding cohort's activation rate and TTW. -->

| Cohort (month) | Customers onboarded | % activated by day X | Median TTW | 90d retention |
|---|---|---|---|---|
|   |   |   |   |   |

## Iteration Log

<!-- INSTRUCTION: Each change to the flow with date and observed impact. -->

| Date | Change made | Hypothesis | Result (after 30 days) |
|---|---|---|---|
|   |   |   |   |

---

## Contamination Check

- Every step references which activation prerequisite it produces: <!-- yes/no -->
- TTW promise is explicit and measured: <!-- yes/no -->
- Friction audit done — each friction either removed/reduced or justified: <!-- yes/no -->
- ONE named owner per customer (not "the team"): <!-- yes/no -->
- Graduation trigger is explicit: <!-- yes/no -->
- Sales-to-onboarding handoff fields enforced: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial onboarding flow documented |
| v1-locked | locked | | Locked when median TTW hits target band |
| v2 | iteration | | Updated when activation rate dips |

## Related files

- `activation-metric-doc.md` — the metric this flow produces
- `sales-playbook.md` — handoff inputs from sales
- `knowledge/gtm/activation-and-retention.md` — Step 2.4 doctrine
- `knowledge/gtm/matrix/skok-time-to-wow.md` — Salsify case
- `knowledge/gtm/hormozi/hormozi-growth-onboarding.md` — friction-cutting principle
- `knowledge/gtm/yc/yc-improving-retention.md` — behavioral signal method
