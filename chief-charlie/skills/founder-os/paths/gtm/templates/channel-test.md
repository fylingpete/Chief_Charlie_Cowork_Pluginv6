---
deliverable_type: channel-test
status: empty_template
team_required: false
source: alex_hormozi_core_four
last_updated: null
version: v1-draft
---

# Channel Test — Pick One, Run Exclusively

> **Status:** empty_template — drafted at start of Step 2.1, locked at end of Step 2.1 with channel result (winner / failed / inconclusive)
> **Team-required:** no (founder-driven)
> **Source:** Hormozi's Core Four + Skok's GTM Model Selection + onboarding Q10 (`current_best_channel`)

> **STRICT ONE-CHANNEL RULE.** Run exactly ONE channel for at least 30 days
> exclusively. Multi-channel parallel testing in Step 2.1 produces no
> reliable signal — too few samples per channel, too much variance. Skok
> and Hormozi both forbid it. Pick one. Run it to a result. Then add #2.

## How to use this file

You wrote your ICP and your message. Now you need to find a way to put
the message in front of the ICP repeatedly, cheaply enough to test if
they buy. That's a channel.

Hormozi's Core Four — Warm Outreach, Content, Cold Outreach, Paid Ads —
covers the full B2B universe. Plus optional: Partner / Referral. Pick
ONE for the first test. Run it for 30+ days exclusively. Decide based
on result, not vibes.

The choice is informed by: (1) your existing `current_best_channel` from
onboarding Q10 (if you already have a working channel, default to
deepening it), (2) your ACV (Skok: low-ACV products can't afford
high-touch channels), (3) Hormozi's recommended order for new founders.

## Rules (from the substance rubric)

- **channel_picked_one (non-negotiable):** exactly ONE channel selected
  and named.
- **channel_has_acv_fit:** channel CAC matches ACV — Skok's 10× scaling
  rule (PLG ~$400 CAC for low-ACV, inside sales ~$5K mid-ACV, field
  sales ~$50K high-ACV).
- **channel_has_volume_target:** explicit weekly volume target with math
  showing how it produces enough conversations to get to a result in
  30-60 days.
- **channel_has_kill_criteria:** "this channel failed if X by week Y" —
  written in advance, not retrofitted.
- **channel_used_q10_signal:** if `current_best_channel` from onboarding
  is set, you addressed why you're either deepening it or switching.

---

## Channel Decision

<!-- INSTRUCTION: One choice from Core Four (or Partner/Referral). Hormozi's recommended order for new founders: Warm → Content → Cold → Paid. -->

- **chosen_channel:** <!-- one of: warm-outreach / content / cold-outreach / paid-ads / partner / referral -->
- **why_this_channel:** <!-- INSTRUCTION: 1-2 sentences. Reference ACV fit and onboarding Q10 signal. -->

## ACV-Channel Fit (Skok GTM Model Selection)

<!-- INSTRUCTION: Skok's rule — CAC scales 10× per touch level. Selling a $99/mo product via field sales kills unit economics from day one. -->

- **our_target_ACV:**
- **expected_CAC_band_for_this_channel:** <!-- ~$400 PLG / ~$5K inside sales / ~$50K field sales / ~$0-100 content/SEO -->
- **fit_check:** <!-- INSTRUCTION: does ACV ≥ 3× expected CAC? If no, wrong channel for this product. -->

## Onboarding Q10 Reconciliation

<!-- INSTRUCTION: From onboarding Q10 you reported `current_best_channel`. Either you're deepening that channel here OR explicitly switching. State which. -->

- **q10_current_best_channel:** <!-- read from path_state -->
- **decision:** <!-- deepen / switch / not-applicable-no-prior-signal -->
- **rationale:** <!-- if switching: why? Skok requires structural reason (ACV mismatch, channel exhausted, etc.) -->

---

## Volume & Math

<!-- INSTRUCTION: How many touches per week to reach a result in 30-60 days? Work backwards from desired outcomes. YC: to get 1 customer you may need 800 cold emails. -->

- **target_outcome_in_30d:** <!-- e.g. "5 booked discovery calls" or "1 paying customer" -->
- **conversion_rate_assumption:** <!-- e.g. "2% reply rate × 30% reply-to-call × 40% call-to-close" -->
- **required_volume_per_week:** <!-- math: outcome ÷ conversion-cascade -->
- **time_per_touch_in_minutes:** <!-- INSTRUCTION: realistic effort per touch (a personalized cold email = 8-15 min, ad-creative = compounding) -->
- **realistic_throughput_check:** <!-- can you actually do this volume? If no, channel is wrong OR volume math is wrong -->

## Test Design

<!-- INSTRUCTION: 30-day exclusive test. No sneaking other channels in. -->

- **test_start_date:**
- **test_end_date:** <!-- exactly +30 days -->
- **exclusivity_commitment:** <!-- yes/no — am I running ANY other channel in parallel? -->
- **target_list_or_audience:** <!-- specific list, ad audience, content topic, etc. -->
- **message_used:** <!-- reference messaging-doc.md and the channel-variant -->

## Kill Criteria — Decided in Advance

<!-- INSTRUCTION: Written BEFORE the test starts. Reduces post-hoc rationalization. -->

- **fail_signal_at_week_2:** <!-- e.g. "<5% reply rate", "0 demos booked", "CPL >$X" -->
- **fail_signal_at_week_4:** <!-- e.g. "<1 closed-won deal", "CAC >$Y", "no repeated wins" -->
- **success_signal_at_week_4:** <!-- e.g. "≥1 closed-won deal that fits ICP, repeatable looking" -->
- **inconclusive_signal:** <!-- what looks neither clearly success nor clearly fail -->

---

## Daily / Weekly Log

<!-- INSTRUCTION: One row per week. -->

| Week | Volume sent / spent | Conversations / clicks | Demos booked | Closed-won | Notes |
|---|---|---|---|---|---|
| 1 |   |   |   |   |   |
| 2 |   |   |   |   |   |
| 3 |   |   |   |   |   |
| 4 |   |   |   |   |   |

## Cost Tracking

- **total_spend_in_test:** <!-- ad budget / list cost / tooling -->
- **total_founder_hours_in_test:**
- **total_attempts:**
- **closed_won:**
- **first_pass_CAC_estimate:** <!-- (spend + founder-hours × hourly-cost) ÷ closed-won -->

---

## Result & Decision

<!-- INSTRUCTION: Filled at end of 30 days. Decision is binary: lock as primary channel, switch, or extend test by 14 days with stated reason. -->

- **result:** <!-- success / fail / inconclusive -->
- **kill_criteria_match:** <!-- which fail/success criterion was hit? -->
- **decision:** <!-- lock-as-primary / switch-to-channel-X / extend-14d -->
- **decision_rationale:**

## Repeat-Win Validation

<!-- INSTRUCTION: Channel locks as primary when ≥2 wins came via this exact channel using the locked playbook. -->

- **repeat_win_count_via_this_channel:**
- **deal_1_id:**
- **deal_2_id:**

## Contamination Check

- Exactly one channel run exclusively for 30+ days: <!-- yes/no -->
- Kill criteria written BEFORE test, not after: <!-- yes/no -->
- ACV ≥ 3× expected channel CAC: <!-- yes/no -->
- Q10 reconciled (deepening or explicit switch with reason): <!-- yes/no -->
- Math shows volume produces a result in 30-60 days: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial test design |
| v1-result | result-logged | | Test ended, result documented |
| v1-locked | locked | | Locked after 5–10 repeat wins |

## Related files

- `knowledge/gtm/repeatable-sales-motion.md` — channel-pick doctrine
- `knowledge/gtm/hormozi/hormozi-core-four.md` — Hormozi's channel framework
- `knowledge/gtm/matrix/skok-gtm-model-selection.md` — CAC-ACV scaling rule
- `messaging-doc.md` — message used in this channel
- `icp-doc.md` — audience this channel must reach
- `sales-playbook.md` — what happens after a touch lands
