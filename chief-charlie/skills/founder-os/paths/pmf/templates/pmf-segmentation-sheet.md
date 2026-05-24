---
deliverable_type: pmf-segmentation-sheet
status: empty_template
team_required: false
source: rahul_vohra_pmf_engine
last_updated: null
---

# PMF Segmentation Sheet

> **Status:** empty_template — updated at every Monthly Review and
> rebuilt at every Quarterly Rebuild
> **Team-required:** no (solo-OK, optional team input)
> **Source:** Rahul Vohra's PMF Engine methodology

## How to use this file

This is the current-state segmentation view. Unlike `pmf-score-history.jsonl`,
which is an append-only time series, this file is a living snapshot that
is overwritten at every Monthly Review. It has three jobs: show the
current V/S/N breakdown with percentages, record the main-benefit
resonance sub-split inside Somewhat Disappointed, and track segment
transitions since the last update. The sub-split matters because only
the resonant sub-group of Somewhat Disappointed feeds roadmap blockers.

## Rules (from the substance rubric)

- **three_counts_recorded:** Very Disappointed, Somewhat Disappointed,
  and Not Disappointed counts all present.
- **somewhat_subsplit_done:** the Somewhat Disappointed bucket is
  further split on main-benefit resonance (with resonance vs. without
  resonance / lost cause).
- **counts_sum_to_total:** V + S + N = total; `somewhat_with_resonance`
  + `somewhat_without_resonance` = `somewhat_disappointed`.
- **sub_split_rule_absolute (continuous, non-negotiable via dependents):**
  only `somewhat_with_resonance` feeds the hopefuls blockers file.

---

## Snapshot metadata

<!-- INSTRUCTION: Update at every Monthly Review. The "as-of date"
field is the reference point readers will use to know whether this
snapshot is current. -->

- **as_of_date:**
- **cumulative_sample_size_since_baseline:**
- **previous_snapshot_date:**
- **last_measurement_id_from_pmf-score-history:**

---

## Current Segment Counts

<!-- INSTRUCTION: Counts come from pmf-survey-responses.jsonl filtered to
the current measurement window. Percentages are of the total. All three
counts must sum to total. -->

| Segment                | Count | % of Total |
|------------------------|-------|------------|
| Very Disappointed      |       |            |
| Somewhat Disappointed  |       |            |
| Not Disappointed       |       |            |
| **Total**              |       | 100%       |

- **pmf_score_percent:** <!-- INSTRUCTION: equal to Very Disappointed % of total; must match the most recent entry in pmf-score-history.jsonl -->
- **benchmark_valid:** <!-- true if total >= 40 -->
- **directional_only:** <!-- true if total < 15 -->

---

## Sub-split at Somewhat Disappointed

<!-- INSTRUCTION: Count each Somewhat Disappointed response by whether
its Q3 (main benefit) answer resonates with the product's actual core
promise. "With resonance" feeds the hopefuls blockers file. "Without
resonance" is the lost-cause sub-group and is excluded from roadmap
input entirely. Check against the sub_split_main_benefit_resonance
field on each response in pmf-survey-responses.jsonl. -->

| Sub-split of Somewhat Disappointed        | Count | % of Somewhat |
|-------------------------------------------|-------|----------------|
| With main-benefit resonance (feeds hopefuls) |       |                |
| Without resonance (lost cause, excluded)     |       |                |
| **Somewhat Disappointed total**              |       | 100%           |

- **sub_split_sum_check:** <!-- INSTRUCTION: with + without must equal somewhat_disappointed in the main counts table. Write "ok" or a note if it does not. -->

---

## Transition Tracking Since Last Update

<!-- INSTRUCTION: Record how the picture has moved since the previous
snapshot. Use aggregate counts by default. Individual respondent IDs
can be referenced if they clarify a material shift. Transitions are
what the Monthly Review conversation is really about — the bare
counts above don't show movement on their own. -->

- **new_responses_since_last_snapshot:**
- **net_change_very_disappointed:** <!-- +N / -N -->
- **net_change_somewhat_disappointed:** <!-- +N / -N -->
- **net_change_not_disappointed:** <!-- +N / -N -->
- **notable_transitions:**
  <!-- INSTRUCTION: Bullet list. Example: "12 new responses this window
  landed Very; 5 new responses landed Somewhat with resonance; 2
  landed Somewhat without resonance; 3 landed Not." Reference
  respondent IDs only when a specific individual's movement is material
  to the roadmap conversation. -->

---

## Notes on Current Distribution

<!-- INSTRUCTION: Free text. What does this snapshot actually mean? Is
the percentage drifting in the right direction? Is the sub-split
getting healthier (more resonance, fewer lost causes)? Anything the
Monthly Review conversation should focus on? This is the one
place in this file where narrative interpretation is expected. -->

## Related files

- `pmf-score-history.jsonl` — time series this snapshot links into
- `pmf-survey-responses.jsonl` — raw data this snapshot summarizes
- `hopefuls-blockers.md` — consumes only the `somewhat_with_resonance` subset
- `fanatics-why-they-love.md` — consumes only the Very Disappointed subset
- `knowledge/pmf-segmentation.md` — why the sub-split rule is absolute
