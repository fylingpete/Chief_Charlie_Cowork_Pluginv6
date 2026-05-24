# GTM Quarterly Rebuild

3-4 hours. Once per quarter. Step out of execution and rebuild the
plan with fresh data. This is the heaviest operation in the GTM path —
it's where strategic course-corrections happen. Skip it and you accrue
playbook-debt that the monthly review can't catch.

## When to run this

- `path_state.cadences.last_quarterly_at` is ≥85 days ago
- Major external signal (market shift, competitor move, churn cliff)
- Cumulative warnings in `path_state.warnings` > 5 since last quarterly
- After 3 monthly reviews show a stagnation pattern

## Pre-flight (15 min)

Read from `dashboard_data.json`:

- `path_state.roadmap.currentSubphase` — drives which sections are active
- `path_state.kpis.rows` — current state
- `path_state.warnings` — accumulated red flags
- `path_state.events_log` — what fired this quarter

Read from logs:

- Last 3 entries from `monthly_review_log.jsonl`
- All decisions+learnings in `decisions_learnings.jsonl` from this quarter
- Channel test results from `channel-test.md` history
- Pipeline data from `bookings-plan.md`

Reference these knowledge files (read before starting):

- `knowledge/gtm/repeatable-sales-motion.md`
- `knowledge/gtm/founder-to-rep-handoff.md`
- `knowledge/gtm/scale-demand-and-sales.md`
- `knowledge/gtm/activation-and-retention.md`
- `knowledge/gtm/unit-economics.md`
- `knowledge/gtm/matrix/skok-the-11-phases.md`
- `knowledge/gtm/matrix/skok-conserve-cash-until-scaling.md`

## Greeting

> "Quarterly Rebuild für GTM Step {currentSubphase}. Wir haben 3-4
> Stunden. Ich gehe mit dir durch alle relevanten Sektionen — manche
> sind step-spezifisch, manche cross-step. Sektionen, die für deinen
> aktuellen Step nicht aktiv sind, überspringen wir."

## Section Filter Logic

Sections are **gated by `currentSubphase`**. The agent runs only the
sections that match. The user can request additional sections at the
end if they want to look ahead.

| Section | 2.1 | 2.2 | 2.3 | 2.4 | 2.5 |
|---|---|---|---|---|---|
| 1. Quarter Recap | ✓ | ✓ | ✓ | ✓ | ✓ |
| 2. ICP & Messaging Audit | ✓ | ✓ | • | • | • |
| 3. Channel Mix Review | ✓ | • | ✓ | • | ✓ |
| 4. Sales Motion / Playbook Audit | ✓ | ✓ | • | • | • |
| 5. Rep Performance & Coaching | — | ✓ | ✓ | • | • |
| 6. Bookings Plan & Math | — | • | ✓ | • | ✓ |
| 7. Activation & Retention Cohorts | — | — | • | ✓ | ✓ |
| 8. Unit Economics & Pricing | — | — | • | • | ✓ |
| 9. Bottleneck Diagnosis | ✓ | ✓ | ✓ | ✓ | ✓ |
| 10. Next-Quarter Plan | ✓ | ✓ | ✓ | ✓ | ✓ |

✓ = primary, • = secondary (review briefly), — = skip

---

## Section 1 — Quarter Recap (every step, 15 min)

```
Was waren die wichtigsten Ergebnisse dieses Quartals?
```

Pull from `decisions_learnings.jsonl` and `monthly_review_log.jsonl`:

- Top 5 decisions made
- Top 5 learnings captured
- KPI arc (start → end of quarter for each row)
- Events that fired this quarter (channel-failed, conversion-drop, etc.)

Output a 1-page summary the user reviews and confirms.

## Section 2 — ICP & Messaging Audit (steps 2.1-2.2, 30 min)

Active when v1-locked is recent OR `path_state.icp_signals` shows drift.

Re-read `icp-doc.md` v-current and `messaging-doc.md` v-current.
Compare against the buyer-conversations and lost-deal patterns from
this quarter:

- Are the ICP positive characteristics still accurate?
- Are the negative characteristics still rejecting the right people?
- Has the buyer's hair-on-fire trigger shifted?
- Has the messaging buyer-word trail picked up new dominant phrases
  that aren't in the current core message?

Decision points:
- **No drift** → re-confirm v-current, log a `quarterly_confirmation`
  entry in `decisions_learnings.jsonl`
- **Minor drift** → schedule `playbook-update.md` for the affected sections
- **Major drift** → schedule `icp-adjustment.md` or `messaging-adjustment.md`
  for next session (don't run them in this quarterly)

## Section 3 — Channel Mix Review (steps 2.1, 2.3, 2.5, 30 min)

Active when channel data is the strategic question.

### For step 2.1

Re-read `channel-test.md` for the active channel.
- Has the kill criterion fired?
- Has the volume/conversion math held?
- Hormozi recommended order check: are we deepening the right channel
  for our stage?

Decision: keep / extend / kill / switch (route to a fresh
`channel-test.md` if switching).

### For step 2.3

Pull lead-source mix from `bookings-plan.md` Lead-Source Mix section.

- Does the top channel exceed 60% (single-channel-dependence risk)?
- Is the next-to-layer channel on track to hit 20% share?
- Are S-curves overlapping as planned (Skok)?
- Has any channel saturated (CPL rising, CTR falling, response rate
  dropping)?

Decision: which channel to deepen, which to add, which to de-emphasize
this quarter. Document in `bookings-plan.md` Lead-Source Mix update.

### For step 2.5

Pull channel-level economics from `unit-economics-model.md`.

- Best channel by LTGP:CAC: ___
- Worst channel by LTGP:CAC: ___
- Channels with LTGP:CAC < 1: kill candidates
- Channel-attributed retention from `activation-metric-doc.md`: which
  channel produces fast-churners?

Decision: kill-channel candidates this quarter, reallocate budget.

## Section 4 — Sales Motion / Playbook Audit (steps 2.1-2.2, 30 min)

Re-read `sales-playbook.md` and walk the stage-by-stage table.

- Are the conversion rates per stage stable?
- Has the median deal cycle time changed?
- Has the demo storyline drifted into feature-tour?
- Are the pricing guardrails being honored?
- Is the hand-off-to-CS criterion working (ask `onboarding-flow.md`
  data)?

Decision: lock playbook for next quarter / schedule `playbook-update.md`
for specific sections / consider `messaging-adjustment.md` if message
drift is causing weak conversion.

## Section 5 — Rep Performance & Coaching (steps 2.2-2.3, 20 min)

Pull rep PPR data from monthly logs.

- Reps at >4× OTE: ___ of ___
- Reps below 2× OTE post-ramp: ___ → cut decision
- Coaching-cadence adherence: ___ %
- Schatz black-sheet reviews per rep this quarter: ___

Decision points:
- Underperformer cut decision (don't defer beyond 1 month)
- Coaching cadence reset if missed
- Pod-cloning trigger check (Pod 1 at quota for 2 quarters?)

## Section 6 — Bookings Plan & Math (steps 2.3, 2.5, 30 min)

Re-derive Bookings = #Reps × PPR for next quarter.

- Headcount plan vs lead-supply plan: do they balance?
- Pipeline coverage trend: at 3-4× or sliding?
- Pipeline velocity trend: improving or stalling?
- Marketing-Sales contract: who owns the gap?

Update `bookings-plan.md` Headline Plan table for next quarter.
Update `marketing-sales-contract.md` if cohort math has matured to
new conversion rates.

## Section 7 — Activation & Retention Cohorts (steps 2.4-2.5, 30 min)

Pull cohort data:

- 12-month logo retention: ___ %
- NDR by cohort: ___ %
- Time-to-Wow by acquisition channel: ___
- Activation-rate by channel: ___ %
- Channel-attributed retention: ___ %

Decision points:
- Activation metric still predictive? Validate against latest cohort.
- Time-to-Wow drifted? Identify friction points to attack.
- Negative-churn (NDR > 100%) achieved? If not, pricing-axes review.
- Channel producing fast-churners → kill candidate (cross-ref Section 3).

## Section 8 — Unit Economics & Pricing (step 2.5, 45 min)

Refresh `unit-economics-model.md` end-to-end:

- Re-compute LTGP from cohorts ≥12mo old
- Re-compute CAC by channel (channel-level, not aggregate)
- Re-validate three gates (LTGP:CAC, payback, margin)
- Rule of 40 check
- Cash-trough position vs runway

Decision points:
- Pricing review: are we under-pricing? Hormozi's premium-pricing
  test scheduled?
- Margin review: support load, infra cost, self-serve migration
- Channel kill candidates from Section 3 → impact on aggregate CAC?
- Phase 3 readiness: all 3 gates passing? → Schedule
  `event-2.5-milestone.md`

## Section 9 — Bottleneck Diagnosis (every step, 20 min)

```
Was war diesen Quarter der größte Bottleneck — und stimmt unsere
Hypothese darüber noch?
```

Re-match `path_state.bottleneck` against the active step's
`roadmap_defaults.bottlenecks` 5 categories. Has the matched category
shifted?

If yes:
- Update `data.bottleneck.title` and `data.bottleneck.description`
- Append a `decision` entry to `decisions_learnings.jsonl`:
  "Bottleneck-Wechsel zu {new_category}"

## Section 10 — Next-Quarter Plan (every step, 30 min)

Based on Sections 1-9, draft 3 priorities for next quarter:

1. **Strategic priority** — what's the single most important shift?
2. **Operational priority** — what process must be tightened?
3. **Experimental priority** — what's the next test (channel, message,
   pricing)?

For each: 1-sentence why, 1-sentence how, 1 metric that says it worked.

Update `dashboard_data.json:path_state.projects` with these 3 priorities.

## Wrap

### Update cadence

```
path_state.cadences.last_quarterly_at = today
path_state.cadences.next_quarterly_due = today + 90 days
```

### Append `quarterly_rebuild` entry

```jsonl
{"date":"YYYY-MM-DD","subphase":"{currentSubphase}","sections_run":[...],"top_decisions":[...],"next_quarter_priorities":[...]}
```

to `quarterly_rebuild_log.jsonl`.

### Schedule follow-up sessions

If sections flagged adjustments, list the next sessions:

- `playbook-update.md` for {template} → {section}
- `icp-adjustment.md` (if drift)
- `messaging-adjustment.md` (if drift)
- `event-2.5-milestone.md` (if all 3 gates pass)
- channel-kill execution

These don't run in this quarterly — they're separate sessions to keep
this one focused.

### Confirm to user

> "Quarterly logged. Top {N} decisions in `decisions_learnings.jsonl`.
> {M} follow-up sessions scheduled. KPI rows aktualisiert. Phase 3
> {ready / not yet / approaching}."

## Rules

- **3-4 hours is the budget.** It's heavy on purpose. Don't try to
  squeeze it into 30 min.
- **Step-filter the sections.** Don't run Unit Economics if the user
  is in 2.1 — the data isn't meaningful yet (Skok stage-appropriate
  rule).
- **Don't run adjustments inline.** The quarterly identifies what
  needs adjusting; separate sessions execute the adjustments.
- **Cross-step trackers preserved.** Bookings (2.2-2.3) and Retention
  (2.4-2.5) values continue across step-boundaries even when the
  primary KPI changes.
- **Be honest about phase.** Don't position the user further than the
  data supports. Skok: skipping ahead burns more cash than going
  slow.

## Related files

- `monthly-review.md` — feeds quarterly with monthly snapshots
- `phase-change.md` — runs when sub-phase advances (separate operation)
- `playbook-update.md` — incremental refinement (separate sessions)
- `icp-adjustment.md`, `messaging-adjustment.md` — major hypothesis
  changes (separate sessions)
- `event-2.5-milestone.md` — Phase 3 switch event
- `quarterly_rebuild_log.jsonl` — append-only log of past quarterlies
