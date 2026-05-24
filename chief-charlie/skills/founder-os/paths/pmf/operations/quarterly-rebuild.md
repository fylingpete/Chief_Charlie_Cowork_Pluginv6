# Quarterly Rebuild Cadence

**Cadence type:** Quarterly deep-work session
**Unlocked when:** Implementation Phase Step 3 (Execution Rhythm Setup) completes
**Frequency:** Quarterly, fixed calendar slot — first Monday of January, April, July, October at 9am, with Chief Charlie; WhatsApp reminder via `manage_reminders`
**Duration:** 3-4 hours (not a single unbroken sit — the 6 parts may be spread across one or two consecutive days)
**Weight:** Heavy — deep work, strategy revision, full roadmap rebuild

This is the deep-work cadence of Rahul Vohra's Superhuman® PMF Engine
methodology. Everything produced in the Implementation Phase (baseline
measurement, HXC™ persona draft, fanatics analysis, hopefuls blockers,
50/50 roadmap, OKR) is re-run against the cumulative data set. The
Quarterly Rebuild is the only cadence where strategy actually changes;
Weekly Check-In observes and Monthly Review measures, but Quarterly
Rebuild *rebuilds*. It also verifies that reminder infrastructure is
still healthy — a small but load-bearing step, because a dropped
reminder can quietly end the operating loop.

## Trigger phrases

The agent routes into this cadence on any of the following:

- "quarterly rebuild"
- "quarterly session"
- "pmf rebuild"
- "rebuild roadmap"
- "quarterly pmf"
- "run quarterly"
- "quarterly" alone — when `dashboard_data.json` is present, current
  `path_state.phase` is `operating`, and the next Quarterly slot
  (`path_state.cadences.quarterly_rebuild.next_due`) is within 14 days
  (before or after)

## Dependencies on state and deliverables

Before starting any Quarterly flow the agent loads:

- `dashboard_data.json` — including `path_state.survey_infrastructure`
  and `path_state.reminders` blocks
- `pmf_survey_responses.jsonl` — the full cumulative response set
- `pmf_score_history.jsonl` — every Monthly entry since the last
  Quarterly
- `pmf-segmentation-sheet.md`
- `hxc-persona.md` — current version marker
- `fanatics-why-they-love.md`
- `hopefuls-blockers.md`
- `pmf-roadmap.md`
- Any `monthly-review-{YYYY-MM}.md` files created since the last
  Quarterly
- Any `score-drop-diagnostic-{YYYY-MM}.md` files from events since
  the last Quarterly
- The previous `quarterly-rebuild-{YYYY-QN}.md` (if one exists)

Knowledge blocks loaded for this cadence:

- `../knowledge/pmf-why-measure.md`
- `../knowledge/pmf-sean-ellis-test.md`
- `../knowledge/pmf-segmentation.md`
- `../knowledge/pmf-hxc-framework.md`
- `../knowledge/pmf-roadmap-fifty-fifty.md`
- `../knowledge/pmf-iteration-loop.md`
- `../knowledge/pmf-anti-patterns.md`

Templates used:

- `../templates/hxc-persona.md`
- `../templates/fanatics-why-they-love.md`
- `../templates/hopefuls-blockers.md`
- `../templates/pmf-roadmap.md`
- `../templates/pmf-score-history.jsonl`
- `../templates/pmf-segmentation-sheet.md`

Rubrics referenced:

- `../assessment/substance-rubrics.md` — Step 1, Step 2, and Step 3
  rubrics are re-used for the rebuild outputs; NN-1 through NN-5 from
  the non-negotiables section are re-verified at the end of each Part

## Part 1 — Previous Quarter Retrospective (45 min)

The retrospective is where the quarter actually ends. Before any
rebuilding, the quarter that is closing gets honestly characterized.

**Step 1 — Score journey.** Read every entry in
`pmf_score_history.jsonl` since the last Quarterly. Report the arc:
starting score → each Monthly reading → current score. Call out the
biggest single-month jump and the biggest drop. Note whether any
Score Drop Events fired during the quarter and what the diagnostics
concluded.

**Step 2 — Roadmap retrospective.** Read the current
`pmf-roadmap.md` side-by-side with the list of items that shipped this
quarter (the user provides the ship list verbally or from a changelog).
For each initiative on the old roadmap, classify it as one of:

- **Shipped with visible impact** — score moved in the expected
  direction after ship
- **Shipped with no visible impact** — shipped but no score movement
  attributable
- **Shipped with reverse impact** — shipped and score moved the wrong
  direction
- **In progress** — started but not shipped
- **Not started** — never got to it

Tally the four classes. Report totals.

**Step 3 — Failed experiments review.** Which initiatives shipped with
no impact or reverse impact? For each, ask the user: what do you think
happened? The answers feed into Part 4's roadmap rebuild (some
experiments inform "don't re-try this" constraints).

**Step 4 — Deliverable: write the retrospective section.** Use
`file_write` to create
`02_PMF/quarterly-rebuild-{YYYY-QN}.md` with the
retrospective content from Steps 1-3. The remaining Parts will append
to this file as they run. Section header: `## Part 1 — Previous
Quarter Retrospective`.

## Part 2 — HXC Re-profiling (30 min)

The High Expectation Customer™ persona (framework attributed to Julie
Supan, assembled into the PMF Engine by Rahul Vohra) may have drifted
as the cumulative Very Disappointed set has grown. Part 2 decides
whether the persona is still accurate.

**Step 1 — Load inputs.** Read the current `hxc-persona.md` (note the
current version marker, e.g. `v1-confirmed`). Filter
`pmf_survey_responses.jsonl` down to Very Disappointed respondents who
have arrived since the last Quarterly (or since the baseline, if there
is no prior Quarterly). Focus on Q2 (who benefits most) and Q3 (main
benefit).

**Step 2 — NN-2 verification.** Per
`../rules/rules.md` NN-2 and the anti-patterns block in
`../knowledge/pmf-anti-patterns.md`, HXC updates come only from Very
Disappointed. The agent checks that the response set being used is
filtered correctly and reports the filter explicitly before
proceeding: "I'm using {N} Very Disappointed responses as the input.
Is that the right scope?"

**Step 3 — Demographic shift check.** In the new Very Disappointed
answers, look at the Q2 role/title/context patterns. Are they the same
as the current persona or have they shifted? Look at Q3 main-benefit
language — is it still resonating on the same core benefit, or has
something new emerged?

**Step 4 — Decision.** Three outcomes:

1. **Confirm-and-lock.** The persona still fits. Update the version
   marker to `v{N}-confirmed-{YYYY-QN}` and note the confirmation date.
2. **Minor update.** One or two attributes (e.g. the frustration or
   desire section) need refinement but the core role and benefit are
   stable. Update the file in place and bump the version to
   `v{N+1}-{YYYY-QN}` with a change-log entry at the bottom of the
   file documenting what moved and why.
3. **Major update.** The persona has materially shifted. Create
   version `v{N+1}-{YYYY-QN}` with a full rewrite of the affected
   sections and a change-log entry summarizing the shift. The old
   version is preserved as an archived block further down the file.

**Step 5 — Write.** Use `file_edit` on `hxc-persona.md` (for outcomes
1 and 2) or a combination of `file_edit` and `file_write` for outcome
3.

**Step 6 — Append to the quarterly file.** Add a `## Part 2 — HXC
Re-profiling` section to `quarterly-rebuild-{YYYY-QN}.md` with the
decision, the filter used, the key observations, and the new version
marker.

## Part 3 — Fanatics & Hopefuls Re-analysis (45 min)

Part 3 rebuilds the two pattern files — `fanatics-why-they-love.md`
and `hopefuls-blockers.md` — from scratch against the current
cumulative data set. These files feed Part 4 (roadmap rebuild) directly.

**Step 1 — Rebuild fanatics.** Filter `pmf_survey_responses.jsonl` to all
Very Disappointed respondents (cumulative, not just new). Extract
patterns from Q3 (main benefit) and Q4 (improvement) with frequency
data — not impressions, actual counts. Aim for at least 3 patterns.
Use `file_write` to replace `fanatics-why-they-love.md` with the
rebuilt content. Include a version note at the top (e.g. `rebuilt
{YYYY-QN} from {N} cumulative Very Disappointed responses`).

**Step 2 — Rebuild hopefuls.** Filter to Somewhat Disappointed
respondents **with main-benefit resonance** in Q3 (the sub-split rule
— NN-1 is absolute here; never include Not Disappointed, never
include the politely-disregarded sub-group). Extract blocker patterns
from Q4 with frequency data. Aim for at least 3 blockers. Use
`file_write` to replace `hopefuls-blockers.md` with the rebuilt
content and a version note.

**Step 3 — Pattern change analysis.** Compare the new fanatics and
hopefuls files against the previous versions (read them before the
`file_write` happens, or use git history if available). Answer two
questions:

1. **What is new?** Which patterns were not in last quarter's files
   and have appeared now?
2. **What dropped off?** Which patterns were prominent last quarter
   and have faded? Faded is not always bad (could mean the blocker
   was unblocked), but it is informative.

**Step 4 — Hope conversion check.** Read the respondent ID list from
the previous quarter's Somewhat-with-resonance group. How many of
those same IDs are now showing up in the Very Disappointed set? (If
the never-re-survey rule is working — and it must, per NN-5 — then
the answer is zero by definition, because respondents never appear
twice.) The hope conversion check instead works at the **pattern
level**: did the Q3 main benefit that Somewhat-with-resonance users
were hoping for last quarter now show up as the confirmed main
benefit in this quarter's Very Disappointed cohort? If yes, the
Unblocking half of last quarter's roadmap was working. Note this in
the quarterly file.

**Step 5 — Append to the quarterly file.** Add a `## Part 3 —
Fanatics & Hopefuls Re-analysis` section summarizing the new patterns,
what dropped off, and the hope-conversion observation.

## Part 4 — Roadmap Rebuild (60 min)

Part 4 is where the quarter's strategy is set. The previous roadmap
is archived and a new one is built from the freshly rebuilt fanatics
and hopefuls files.

**Step 1 — Archive the previous roadmap.** Use `file_edit` on
`pmf-roadmap.md` to:

- Move every **shipped** initiative into a section titled
  `## Archive — Shipped in {YYYY-QN}` at the bottom of the file
- Move every **in-progress or not-started** initiative into a section
  titled `## Backlog — Deferred from {YYYY-QN}` at the bottom of the
  file
- Clear the active roadmap sections

**Step 2 — Build the Doubling Down half.** From the newly rebuilt
`fanatics-why-they-love.md`, generate candidate initiatives that
double down on the top fanatics patterns. Minimum 5 initiatives. Each
initiative gets:

- A one-line description
- Which fanatics pattern it amplifies (trace back to a specific
  pattern in the file)
- Cost label: Low / Medium / High (engineering effort)
- Impact label: Low / Medium / High (estimated score impact)
- Priority tier: quick wins (Low cost × High impact) first, then
  strategic bets

**Step 3 — Build the Unblocking half.** From the newly rebuilt
`hopefuls-blockers.md`, generate candidate initiatives that unblock
the top hopefuls blockers. Minimum 5 initiatives. Each initiative gets
the same metadata. **Sub-split rule verification (NN-1):** the agent
must trace each blocker-initiative back to a specific
Somewhat-with-resonance response in the raw data. If a proposed
initiative does not trace, it is dropped — no exceptions.

**Step 4 — 50/50 verification.** Count the initiatives in each half.
Per NN-4, the split must be between 40/60 and 60/40. If it is outside
that band, the agent stops and asks the user to add or remove
initiatives before proceeding. The 50/50 rule is one of the strictest
in the methodology — skewing too far in either direction is the
failure mode Rahul Vohra warned about (paraphrased: doubling down
alone stalls the score; unblocking alone lets competitors overtake).

**Step 5 — Quick wins pass.** Mark every Low-cost × High-impact
initiative across both halves with a `quick-win` tag and stack them
first in execution order.

**Step 6 — Write the new roadmap.** Use `file_edit` on
`pmf-roadmap.md` to insert the new active roadmap sections above the
archive. Structure: Doubling Down section, Unblocking section,
execution order list, cost/impact legend, version note at the top
(`rebuilt {YYYY-QN}`).

**Step 7 — Append to the quarterly file.** Add a `## Part 4 — Roadmap
Rebuild` section with the count per half, the quick-wins list, and a
pointer to the rebuilt `pmf-roadmap.md`.

## Part 5 — Next Quarter OKR & Dates (15 min)

**Step 1 — Set the next score target.** Based on the current score
and the trajectory from Part 1, propose a target %-score for the next
quarter. Examples: if current is 28% and trajectory is +3 pts/month,
propose 37% as a stretch or 33% as realistic. The user picks.

**Step 2 — Update `dashboard_data.json` `path_state`.** Use the JSON
update mechanism to update:

- Move the prior `path_state.okr.current` to `path_state.okr.previous`
  (with final outcome)
- Set `path_state.okr.current` to:
  ```
  target_score: {N}
  quarter: {YYYY-QN+1}
  primary_kr: "% very disappointed"
  start_score: {current}
  status: on_track
  ```
- `path_state.cadences.quarterly_rebuild.last_run: {today}`
- `path_state.cadences.quarterly_rebuild.next_due: {first Monday of next quarter}`
- Increment `path_state.cadences.quarterly_rebuild.count`
- `path_state.last_session_date: {today}`, increment
  `path_state.session_count`
- If the HXC was rewritten in Part 2, record the version bump in
  `path_state.hxc.version` (and a one-line note in
  `path_state.notes`).

**Step 3 — Verify Monthly and Quarterly dates in state.**
Read `dashboard_data.json` →
`path_state.cadences.monthly_review.next_due` and
`path_state.cadences.quarterly_rebuild.next_due`. Confirm the next
Monthly (first Monday of next month) and next Quarterly (first Monday
of next quarter) dates are present and correct. Also mirror these to
`@FOUNDER_HARNESS.md` → Recurring Sessions section. Update via
`file_edit` if stale.

**Step 4 — Append to the quarterly file.** Add a `## Part 5 — Next
Quarter OKR & Dates` section documenting the new target, the
reasoning, and the confirmed dates.

## Part 6 — Reminder Verification (5 min)

Reminder infrastructure is part of the operating loop. A dropped or
drifted reminder is the most common silent failure mode of the PMF
Engine, which is why verification is a formal step every quarter.

**Step 1 — Read the reminder block.** Read `dashboard_data.json` →
`path_state.reminders`. Three reminder IDs should be documented:
`weekly_checkin.id`, `monthly_review.id`, `quarterly_rebuild.id`.
Plus the user's WhatsApp number reference (from
`path_state.user_profile`) and `path_state.reminders.last_verified`
timestamp.

**Step 2 — Verify via `manage_reminders`.** Call the Chief Charlie
`manage_reminders` tool with the three documented reminder IDs.
Possible results per reminder:

- **Active and on schedule** — no action needed
- **Active but drifted** — timezone change, schedule change, or
  user-edited on another device. Update via `manage_reminders` to
  match the documented schedule.
- **Missing/deleted** — the reminder no longer exists in the user's
  reminder system. Re-create via `manage_reminders` with the original
  schedule and record the new reminder ID.
- **User opted out since last verification** — the user deleted the
  reminder intentionally. Confirm with the user that the opt-out is
  still intentional; if yes, set
  `path_state.reminders.opted_out: true` and
  `path_state.reminders.status: opted_out` in `dashboard_data.json`,
  and stop verifying that ID.

**Step 3 — Update state.** Update `dashboard_data.json` →
`path_state.reminders.last_verified: {today}` and update any changed
reminder IDs. Mirror schedule changes to `@FOUNDER_HARNESS.md` →
Recurring Sessions section if needed.

**Step 4 — Append to the quarterly file.** Add a `## Part 6 —
Reminder Verification` section with a one-line-per-reminder status
report.

## Session end summary

Per Core Rule 9 in `SKILL.md`, 2-4 lines:

> *"Quarterly Rebuild {YYYY-QN} done — score journey {start} →
> {end} ({delta} pts), HXC {version status}, new roadmap has {N}
> Doubling Down + {M} Unblocking initiatives with {K} quick wins,
> next Monthly on {next_monthly_due}, next Quarterly on
> {next_quarterly_due}, reminders {verified_status}."*

## What Quarterly Rebuild does NOT do

- **It does not restart Implementation Phase.** Implementation ran
  once, at onboarding. Quarterly Rebuild re-runs the analysis and the
  roadmap, not the onboarding flow. `pmf-plan.md` is not touched.
- **It does not re-run the Weekly Check-In or Monthly Review.**
  Those stay on their own schedules.
- **It does not re-survey old respondents.** NN-5 remains absolute.
  The cumulative set grows by new respondents only.

## References

- All 7 knowledge blocks in `../knowledge/`
- `../templates/hxc-persona.md`, `fanatics-why-they-love.md`,
  `hopefuls-blockers.md`, `pmf-roadmap.md`, `pmf-score-history.jsonl`,
  `pmf-segmentation-sheet.md`
- `../assessment/substance-rubrics.md` — Step 1, Step 2, Step 3
  rubrics re-used for rebuild verification
- `../rules/rules.md` — NN-1 through NN-5 and all 8 recommendations
- `weekly-checkin.md` — lightweight cadence
- `monthly-review.md` — medium cadence
- `event-40-milestone.md` — Event 1 (40% milestone)
- `event-score-drop.md` — Event 2 (score drop)
- `event-no-response.md` — Event 3 (no response)
