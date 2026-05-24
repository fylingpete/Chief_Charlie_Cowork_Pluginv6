---
deliverable_type: fanatics-why-they-love
status: empty_template
team_required: false
source: rahul_vohra_pmf_engine
last_updated: null
---

# Fanatics — Why They Love It

> **Status:** empty_template — drafted during Step 2 and rebuilt at each Quarterly Rebuild
> **Team-required:** no (solo-OK, optional team input)
> **Source:** Rahul Vohra's PMF Engine methodology

> **SOURCE FILTER.** Every pattern in this file is extracted from the
> Q3 (main benefit) and Q4 (how to improve) answers of Very Disappointed
> respondents ONLY. Somewhat Disappointed responses are not eligible.
> Not Disappointed responses are not eligible. Contamination from any
> other source invalidates the whole analysis.

## How to use this file

This file holds the ranked list of themes that the fanatics — the Very
Disappointed segment — actually love about the product. The method is
straightforward: read every Very Disappointed Q3 and Q4 answer, cluster
recurring language, count occurrences, and record the top patterns with
their frequencies and supporting response IDs. This file then feeds
directly into the "doubling down" half of the 50/50 roadmap.

Aim for at least three distinct patterns before building the roadmap.
Fewer than three is a signal that either the sample is too small or the
clustering has collapsed too aggressively.

## Rules (from the substance rubric)

- **source_is_very_disappointed_only (non-negotiable via dependents):**
  every pattern traces to Very Disappointed responses and no others.
- **min_three_patterns (recommendation):** at least three distinct
  patterns are present before the roadmap is built.
- **fanatics_patterns_have_frequency (recommendation):** every pattern
  carries a frequency count, not a label or impression.
- **paraphrased_quotes_not_verbatim (recommendation):** example quotes
  are paraphrased unless the respondent has explicitly permissioned
  verbatim use.

---

## Extraction metadata

<!-- INSTRUCTION: Fill in once per build of this file. Rebuilt at every
Quarterly Rebuild with the latest data. -->

- **as_of_date:**
- **very_disappointed_responses_reviewed:**
- **clustering_method:** <!-- INSTRUCTION: brief description of how the clustering was done — tagged in a spreadsheet, word cloud visualization, manual grouping, etc. -->
- **minimum_pattern_threshold:** 3

---

## Top Patterns

<!-- INSTRUCTION: Append a new ### Pattern #{N} block for each distinct
pattern you identify. Rank them by frequency — Pattern #1 is the most
frequently cited. Every pattern must have a frequency count, at least
one paraphrased example, and the source respondent IDs. Minimum 3
patterns recommended. -->

### Pattern #1: {Pattern Name}

- **frequency:** <!-- INSTRUCTION: N of M — e.g. "14 of 38 Very Disappointed mention this" -->
- **source_annotation:** <!-- INSTRUCTION: comma-separated respondent IDs. Every ID listed must be a Very Disappointed respondent in pmf-survey-responses.jsonl. -->
- **paraphrased example quotes (NOT verbatim):**
  - "..."
  - "..."
- **notes:** <!-- INSTRUCTION: optional additional context — what makes this pattern distinctive, how it differs from adjacent patterns, why it might be a doubling-down target -->

---

### Pattern #2: {Pattern Name}

- **frequency:**
- **source_annotation:**
- **paraphrased example quotes (NOT verbatim):**
  - "..."
  - "..."
- **notes:**

---

### Pattern #3: {Pattern Name}

- **frequency:**
- **source_annotation:**
- **paraphrased example quotes (NOT verbatim):**
  - "..."
  - "..."
- **notes:**

---

<!-- INSTRUCTION: Add Pattern #4, #5, etc. as the data supports. More
than ten patterns usually means the clustering is too fine and should
be consolidated. Fewer than three means the clustering is too coarse
or the sample is too small — collect more responses before finalizing. -->

## Coverage check

<!-- INSTRUCTION: Quick self-audit before using this file as a roadmap
input. Every "no" is a warning flag. -->

- Every pattern traces to Very Disappointed responses and no others: <!-- yes/no -->
- Every pattern has a frequency count: <!-- yes/no -->
- Every pattern has at least one paraphrased example: <!-- yes/no -->
- At least three distinct patterns are present: <!-- yes/no -->
- No verbatim quote is present without explicit permission: <!-- yes/no -->

## Related files

- `pmf-survey-responses.jsonl` — the raw data this file is built from
- `pmf-segmentation-sheet.md` — confirms which responses are Very Disappointed
- `hxc-persona.md` — the paired persona from the same source segment
- `pmf-roadmap.md` — the doubling-down path this file feeds into
- `knowledge/pmf-fanatics-analysis.md` — the method
