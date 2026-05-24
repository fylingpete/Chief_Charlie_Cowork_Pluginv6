---
deliverable_type: pmf-roadmap
status: empty_template
team_required: false
source: rahul_vohra_pmf_engine
last_updated: null
---

# PMF Roadmap (50/50 split)

> **Status:** empty_template — built during Step 2 and rebuilt at each Quarterly Rebuild
> **Team-required:** no (solo-OK, optional team input)
> **Source:** Rahul Vohra's PMF Engine methodology

## How to use this file

This is the action half of the skill. The analysis files
(`fanatics-why-they-love.md` and `hopefuls-blockers.md`) produced ranked
lists of what the fanatics love and what is blocking the hopefuls. This
file turns those lists into a quarterly roadmap with a strict
constraint: approximately half of capacity goes to doubling down on
fanatics patterns, and approximately half goes to unblocking hopefuls.
Every item carries an explicit cost label and an explicit impact label.
Low-cost / high-impact items are marked as quick wins and are
prioritized first within each half.

The file is rebuilt at every Quarterly Rebuild. Previous-quarter items
are not deleted — shipped and dropped items are moved to the Archive
section at the bottom so the trajectory of past decisions is preserved.

## Rules (from the substance rubric)

- **fifty_fifty_roadmap_split (non-negotiable):** capacity allocation
  must sit between 40/60 and 60/40 across the two halves. Outside that
  band fails the gate.
- **min_five_per_path (recommendation):** aim for at least five
  initiatives on each half.
- **cost_labels (recommendation):** every initiative has an explicit
  Low / Medium / High cost label.
- **impact_labels (recommendation):** every initiative has an explicit
  Low / Medium / High impact label.
- **priority_order (recommendation):** Quick Wins (Low cost × High
  impact) come first in each half. Balance the 50/50 after quick wins
  are placed.

---

## Current Quarter

<!-- INSTRUCTION: Set the quarter reference. The whole file is rebuilt
from scratch at the start of each quarter; mid-quarter updates move
items between statuses rather than add or remove them. -->

- **quarter:** <!-- e.g. 2026-Q2 -->
- **build_date:**
- **previous_quarter_file_snapshot_link:** <!-- INSTRUCTION: optional — link or path to the prior-quarter version of this file if one was preserved -->
- **source_files:**
  - `fanatics-why-they-love.md` as of: <!-- date -->
  - `hopefuls-blockers.md` as of: <!-- date -->

---

## Part 1 — Doubling Down (sourced from fanatics-why-they-love.md)

<!-- INSTRUCTION: Each initiative must map to a specific pattern in
fanatics-why-they-love.md. If a pattern has no initiative here, record
why in the notes. If an initiative has no source pattern, it does not
belong in this half. Aim for at least 5 initiatives. -->

#### Initiative: {Name}

- **source_pattern:** <!-- INSTRUCTION: link to the named pattern in fanatics-why-they-love.md — e.g. "Pattern #1: {Pattern Name}" -->
- **cost:** <!-- Low | Medium | High -->
- **impact:** <!-- Low | Medium | High -->
- **quick_win:** <!-- INSTRUCTION: yes only if cost = Low AND impact = High -->
- **status:** <!-- not_started | in_progress | shipped | archived -->
- **owner:** <!-- optional -->
- **notes:**

---

#### Initiative: {Name}

- **source_pattern:**
- **cost:**
- **impact:**
- **quick_win:**
- **status:**
- **owner:**
- **notes:**

---

<!-- INSTRUCTION: Duplicate the initiative block until you have at
least 5 entries on this side. -->

### Part 1 subtotal

- **initiative_count:**
- **quick_win_count:**
- **estimated_capacity_percent:** <!-- INSTRUCTION: rough share of total capacity this half consumes. Must be between 40% and 60% to pass the gate. -->

---

## Part 2 — Unblocking (sourced from hopefuls-blockers.md)

<!-- INSTRUCTION: Each initiative must map to a specific blocker in
hopefuls-blockers.md, and by inheritance must trace back to a
qualified-hopefuls respondent (Somewhat Disappointed with main-benefit
resonance). The sub-split rule is inherited from that file — if a
blocker in the source file is clean, the initiative here is clean.
Aim for at least 5 initiatives. -->

#### Initiative: {Name}

- **source_blocker:** <!-- INSTRUCTION: link to the named blocker in hopefuls-blockers.md — e.g. "Blocker #1: {Blocker Name}" -->
- **cost:** <!-- Low | Medium | High -->
- **impact:** <!-- Low | Medium | High -->
- **quick_win:** <!-- yes only if cost = Low AND impact = High -->
- **status:** <!-- not_started | in_progress | shipped | archived -->
- **owner:**
- **notes:**

---

#### Initiative: {Name}

- **source_blocker:**
- **cost:**
- **impact:**
- **quick_win:**
- **status:**
- **owner:**
- **notes:**

---

<!-- INSTRUCTION: Duplicate the initiative block until you have at
least 5 entries on this side. -->

### Part 2 subtotal

- **initiative_count:**
- **quick_win_count:**
- **estimated_capacity_percent:** <!-- must be between 40% and 60% to pass the gate -->

---

## 50/50 Gate Check

<!-- INSTRUCTION: Self-audit before closing Step 2. Any "no" answer is
a hard gate failure unless the non-negotiable is explicitly bypassed. -->

- **part1_capacity_percent:**
- **part2_capacity_percent:**
- **split_within_40_60_to_60_40:** <!-- yes/no -->
- **min_five_initiatives_in_part1:** <!-- yes/no (recommendation) -->
- **min_five_initiatives_in_part2:** <!-- yes/no (recommendation) -->
- **every_item_has_cost_label:** <!-- yes/no (recommendation) -->
- **every_item_has_impact_label:** <!-- yes/no (recommendation) -->

---

## Priority Order

<!-- INSTRUCTION: Ordered list across both halves. Quick Wins (Low cost
× High impact) go first regardless of which half they came from. After
the quick wins are placed, the remaining items interleave to preserve
the 50/50 balance. -->

1.
2.
3.
4.
5.
6.
7.
8.
9.
10.

---

## Archive (previous quarter items)

<!-- INSTRUCTION: When an initiative is shipped or dropped, move it
here rather than deleting it. The archive is the trajectory of past
decisions and is useful at the next Quarterly Rebuild to see what
actually moved the number. -->

| Quarter | Initiative | Source (pattern/blocker) | Final status | Outcome note |
|---------|------------|---------------------------|--------------|--------------|
|         |            |                           |              |              |
|         |            |                           |              |              |

## Related files

- `fanatics-why-they-love.md` — Part 1 source
- `hopefuls-blockers.md` — Part 2 source
- `pmf-score-history.jsonl` — the number this roadmap is trying to move
- `pmf-segmentation-sheet.md` — the V/S/N distribution this roadmap responds to
- `knowledge/pmf-roadmap-50-50.md` — why the 50/50 constraint exists
