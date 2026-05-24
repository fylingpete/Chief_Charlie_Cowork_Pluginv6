# Monthly Review Cadence

**Cadence type:** Monthly recurring measurement session
**Unlocked when:** Implementation Phase Step 3 (Execution Rhythm Setup) completes
**Frequency:** Monthly, fixed calendar slot — first Monday of each month, 9am, with Chief Charlie; WhatsApp reminder via `manage_reminders`
**Duration:** 30-60 minutes
**Weight:** Medium — real measurement with interpretation

This is the cadence where the official %-score from the Sean Ellis
Test™ (Sean Ellis) actually moves. Weekly Check-In observes; Monthly
Measurement measures. The output is a new entry in
`pmf_score_history.jsonl`, an updated segmentation sheet, and a written
observation file for the month. It runs on top of Rahul Vohra's
Superhuman® PMF Engine methodology and carries the same substance
rules as the baseline measurement in Step 1c, just applied to the
growing cumulative response set.

## Trigger phrases

The agent routes into this cadence on any of the following:

- "monthly review"
- "monthly check"
- "update score"
- "pmf monthly"
- "run monthly"
- "recalculate pmf score"
- "monthly" alone — when `dashboard_data.json` is present, current
  `path_state.phase` is `operating`, and the next Monthly slot
  (`path_state.cadences.next_monthly_due`) is within 7 days (before or
  after)

## Dependencies on state and deliverables

Before starting any Monthly flow the agent loads:

- `dashboard_data.json` — reads `path_state.phase` (should be
  `operating`), `path_state.cadences.monthly_review.last_run`,
  `path_state.events`, `path_state.okr.current`,
  `path_state.survey_infrastructure` (connector availability,
  engaged-user source), `path_state.reminders`. Note: the latest score
  and current segment counts are NOT in `dashboard_data.json` — read
  them from the last data line of `pmf_score_history.jsonl`.
- `pmf_survey_responses.jsonl` — the cumulative append-only response set
- `pmf_score_history.jsonl` — the append-only score time series
- `pmf-segmentation-sheet.md` — current V/S/N breakdown with sub-split

Knowledge blocks loaded for this cadence:

- `../knowledge/pmf-sean-ellis-test.md` — scoring formula and the 40%
  rule
- `../knowledge/pmf-segmentation.md` — V/S/N + sub-split mechanics
- `../knowledge/pmf-iteration-loop.md` — why Monthly exists at all and
  how it connects to Quarterly

Templates used:

- `../templates/pmf-score-history.jsonl` — append-only score entry format
- `../templates/pmf-segmentation-sheet.md` — the segmentation sheet
  that gets updated in place
- `../templates/pmf-survey-responses.jsonl` — append format for new rows

## Flow 1 — Prework (before running the measurement)

Typical timing: at the start of the Monthly session.

**Step 1 — Load all state.** Read `dashboard_data.json` (parse JSON
for structured `path_state.*` fields) in one pass. Note: last Monthly
date, current score, current segment counts, active OKR, any pending
events, survey infrastructure, reminder block.

**Step 2 — Check the survey connector.** Read `dashboard_data.json` →
`path_state.survey_infrastructure.platform` and
`path_state.survey_infrastructure.connector_available`. Is a connector
documented (e.g. Typeform, Google Forms, Airtable, Notion,
SurveyMonkey, custom API, manual)?

**Step 3 — Decide how new responses will arrive.**

- If a connector is available and wired: the agent offers to pull new
  responses automatically using the documented tool. Confirm with the
  user, then fetch.
- If no connector or manual-only: the agent asks the user for the new
  responses via CSV paste, Notion export, email attachment, or direct
  entry. Give the user the expected columns: respondent_id, timestamp,
  Q1 bucket, Q2, Q3, Q4, engagement_verified.

**Step 4 — Confirm scope.** Tell the user plainly: "I'm about to add
{N} new responses to the cumulative set. The current total is {M}. New
total will be {M + N}. Proceed?" Wait for confirmation.

## Flow 2 — Run (the measurement itself)

**Step 1 — Append new responses.** Use `file_edit` to append each new
row to `pmf_survey_responses.jsonl` (one JSON record per line, append
at end of file, schema header on line 1 untouched). Append-only — never
rewrite existing
rows, never reorder.

**Step 2 — Run the never-re-survey check.** For each new respondent_id,
scan the already-surveyed `respondent_id` values across all data lines
of `pmf_survey_responses.jsonl` to
confirm the ID is not a repeat. If any repeat is detected, the agent
stops the flow, reports the duplicates to the user, and asks whether
to drop them or investigate. Per Core Rule 8 and NN-5 in
`../rules/rules.md`, re-surveying the same user compromises the 40%
benchmark and is not permitted.

**Step 3 — Recalculate the score.** Compute:

> `score = (very_disappointed_count / total_cumulative_responses) × 100`

Using the full cumulative set, not just the new batch. Report the new
score and the delta vs. the previous Monthly.

**Step 4 — Update V/S/N counts.** Use `file_edit` on
`pmf-segmentation-sheet.md` to update Very / Somewhat / Not
Disappointed counts, matching the cumulative set. This is an
in-place update — the sheet tracks the current state, not history.

**Step 5 — Re-run the sub-split at Somewhat.** For each Somewhat
Disappointed respondent, does their Q3 answer mention the main benefit
of the product? Split Somewhat into "with main-benefit resonance"
(high-potential hopefuls, who can feed the 50/50 roadmap's unblocking
half) and "without resonance" (the politely-disregarded sub-group). NN-1
in `../rules/rules.md` is absolute here — only Somewhat-with-resonance
may inform blockers.

**Step 6 — Trend analysis vs. last Monthly.** Report three deltas:

1. Score delta (pts): `current_score - previous_monthly_score`
2. Segment shifts: how did V/S/N counts change proportionally?
3. Response rate: new responses this month vs. new responses last
   month, with the direction called out

**If the score dropped by more than 5 points, the agent must also
trigger the Score Drop Event workflow** (defined in
`event-score-drop.md`). The Monthly flow does not stop — it runs to
completion and the Score Drop workflow runs after. See the "Event
integration" section below.

**Step 7 — Pattern check in new responses.** Read the new responses
with the pattern question in mind: are fanatics patterns (in Very
Disappointed Q3/Q4) still the same top themes, or has something new
emerged? Are new blocker themes surfacing in Somewhat-with-resonance
Q4? This is observation-level — not a full rebuild (that is
Quarterly's job) — but anything strong enough to stand out gets logged
in the observation file at Followup.

**Step 8 — Roadmap progress check.** Read `pmf-roadmap.md`. What
shipped since the last Monthly? Is there a visible correlation between
what shipped and the score delta? If a Doubling Down initiative shipped
and the Very count rose, note that. If an Unblocking initiative shipped
and the Somewhat-with-resonance count shrank (because those users
converted to Very), note that too. Correlation is not causation — the
agent reports observations, never claims.

**Step 9 — OKR progress check.** Read the active OKR from
`dashboard_data.json` → `path_state.okr.current`. Where does the current
score sit relative to the quarterly target? How much of the quarter is
left? Is the trajectory on track, tight, or off?

## Flow 3 — Followup (write, update, close)

**Step 1 — Append to `pmf_score_history.jsonl`.** Build a single
JSON record matching the file's schema (see header on line 1):
`id`, `date`, `kind: "monthly"`, `score_percent`, `sample_size`,
`sample_size_since_baseline`, `benchmark_valid`, `directional_only`
(true if cumulative < 40), `segment_counts`, `sub_split`,
`delta_from_previous`, `trend_direction`, `correction_of: null`,
`observations`. Append it as a new line at the end via `file_edit`:
`old_string` = current last line of the file, `new_string` =
current last line + `\n` + the new JSON record. Never overwrite
prior lines. Never touch the schema header.

**Step 2 — Write the monthly observation file.** Use `file_write` to
create `02_PMF/monthly-review-{YYYY-MM}.md`. The
file contains:

- Date of measurement
- Score before / score after / delta
- Segment shifts table (V/S/N before and after)
- Sub-split at Somewhat before and after
- Pattern observations from Step 7
- Roadmap progress observations from Step 8
- OKR progress from Step 9
- Alarming signals (if any were forwarded from Weekly Check-In)
- Open questions for the next Quarterly Rebuild

**Step 3 — Update `dashboard_data.json` `path_state`.** Use
`file_edit` (or the JSON update mechanism) to update the following
JSON paths:

- `path_state.last_session_date: {today}`
- Increment `path_state.session_count`
- `path_state.cadences.monthly_review.last_run: {today}`
- `path_state.cadences.monthly_review.next_due: {first_monday_of_next_month}`
- Increment `path_state.cadences.monthly_review.count`
- If Step 6 detected a score drop, append a record to
  `path_state.events.score_drops.pending` with
  `{detected: today, from, to, delta, diagnostic_file}`
- If the user immediately ran the diagnostic this same session,
  move that record from `path_state.events.score_drops.pending` to
  `path_state.events.score_drops.handled`
- Mirror the new score and segment counts into
  `path_state.readiness.pmf_score` and
  `path_state.readiness.segment_counts` so the dashboard reflects
  the latest measurement (the authoritative history still lives in
  `pmf_score_history.jsonl`).

Note: the authoritative score record is the new line just appended to
`pmf_score_history.jsonl`; `path_state.readiness.*` is a denormalized
mirror for fast dashboard reads.

**Step 4 — Session end summary.** Per Core Rule 9, 2-4 lines:

> *"Monthly {YYYY-MM} done — score {new_score}% ({delta} vs. last
> month), {V}/{S}/{N} segments, {observation headline}. Next Monthly
> on {next_monthly_due}. {Score Drop Event ran: yes/no}."*

## Event integration

Two events can fire from inside a Monthly Review. The agent
surfaces them before closing the session.

**Event — Score Drop.** Triggered at Flow 2 Step 6 when
`(previous_score - current_score) > 5`. The Monthly flow completes
normally, then the agent says:

> *"Heads up — the score dropped by {delta} points, which triggers the
> Score Drop diagnostic. Want to run it now while the data is fresh, or
> schedule it for the next session?"*

If the user runs it now, the agent follows the Score Drop workflow in
`event-score-drop.md`, producing
`02_PMF/score-drop-diagnostic-{YYYY-MM}.md`. If deferred, the event
stays in `path_state.events.score_drops.pending` in
`dashboard_data.json`, and the next session start surfaces it before
any other routing.

**Event — 40% Milestone Reached.** Triggered at Flow 2 Step 3 when
`previous_score < 40 AND current_score >= 40 AND
path_state.events.forty_percent_milestone.fired == false`. Fires
**once**. The Monthly flow pauses at the score report, the agent runs
the 40% milestone workflow from `event-40-milestone.md` (celebration
+ lock-in review of the 3 key initiatives that drove the rise +
reminder that iteration continues), sets
`path_state.events.forty_percent_milestone.fired = true` permanently,
then resumes the rest of the Monthly flow.

## What Monthly Review does NOT do

- **Full HXC re-profiling.** That is a Quarterly activity. The Monthly
  flow may notice persona drift and log it, but the formal re-profile
  is in `quarterly-rebuild.md` Part 2.
- **Rebuild the roadmap.** Monthly observes roadmap impact; it does
  not archive or replace the roadmap. Roadmap rebuild is Quarterly
  Part 4.
- **Rebuild fanatics or hopefuls files.** Monthly observes pattern
  drift; Quarterly rebuilds the pattern files.
- **Change the OKR.** OKR is set at Step 3 and revised at Quarterly.

Any request that implies the above reroutes the user: "That sounds
like a Quarterly Rebuild activity — we're scheduled for {date}. Want
to wait, or run it early?"

## References

- `../knowledge/pmf-sean-ellis-test.md` — scoring formula, 40% rule
- `../knowledge/pmf-segmentation.md` — V/S/N and sub-split
- `../knowledge/pmf-iteration-loop.md` — monthly cadence rationale
- `../templates/pmf-score-history.jsonl` — append-only score format
- `../templates/pmf-segmentation-sheet.md` — segmentation update format
- `../templates/pmf-survey-responses.jsonl` — append format
- `../rules/rules.md` — NN-5 (never re-survey), NN-1 (sub-split)
- `weekly-checkin.md` — the lighter cadence above
- `quarterly-rebuild.md` — the deeper cadence below
