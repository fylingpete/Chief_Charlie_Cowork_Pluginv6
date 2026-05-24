---
deliverable_type: hopefuls-blockers
status: empty_template
team_required: false
source: rahul_vohra_pmf_engine
last_updated: null
---

# Hopefuls — What Blocks Them

> **Status:** empty_template — drafted during Step 2 and rebuilt at each Quarterly Rebuild
> **Team-required:** no (solo-OK, optional team input)
> **Source:** Rahul Vohra's PMF Engine methodology

> **STRONG WARNING — SUB-SPLIT RULE IS ABSOLUTE.**
>
> Every blocker in this file must come from Somewhat Disappointed
> respondents WHOSE Q3 (MAIN BENEFIT) ANSWER RESONATES with the product's
> actual core promise. This is the qualified "hopefuls" sub-segment.
>
> Blockers from Not Disappointed respondents are EXCLUDED.
> Blockers from the lost-cause sub-group of Somewhat Disappointed —
> those whose Q3 answer does NOT resonate with the core promise — are
> EXCLUDED.
>
> This rule is non-negotiable. It exists because feedback from users who
> do not feel the core value will pull the roadmap toward features that
> will never produce strong attachment. Including them looks generous;
> it actually dilutes the signal from the users who are close to falling
> in love and lets a lost-cause subset shape direction.

## How to use this file

This file holds the ranked list of frictions that are preventing
otherwise-close users from crossing into the Very Disappointed bucket on
the next survey. The source is narrow by design: only the qualified
hopefuls sub-segment contributes. Read their Q4 (improvement) answers,
cluster, count, and record the top blockers with their frequencies and
supporting response IDs. Every blocker must be traceable to a specific
response ID that has been verified to pass the sub-split filter.

This file feeds directly into the "unblocking" half of the 50/50
roadmap.

## Rules (from the substance rubric)

- **sub_split_rule_absolute (non-negotiable):** every blocker traces
  to a Somewhat Disappointed response whose main-benefit answer
  resonates with the product's core promise.
- **source_is_somewhat_with_resonance_only:** no Not Disappointed
  inputs; no lost-cause Somewhat inputs.
- **min_three_blockers (recommendation):** at least three distinct
  blockers are present before the roadmap is built.
- **hopefuls_blockers_have_frequency (recommendation):** every blocker
  carries a frequency count.
- **paraphrased_quotes_not_verbatim (recommendation):** example quotes
  are paraphrased unless the respondent explicitly permissioned
  verbatim use.

---

## Extraction metadata

<!-- INSTRUCTION: Fill in once per build. Rebuilt at every Quarterly
Rebuild with the latest data. -->

- **as_of_date:**
- **qualified_hopefuls_responses_reviewed:** <!-- INSTRUCTION: count of Somewhat Disappointed respondents with main-benefit resonance. Must match the "with resonance" count in pmf-segmentation-sheet.md. -->
- **excluded_lost_cause_count:** <!-- INSTRUCTION: Somewhat Disappointed without resonance — NOT used in this file, recorded here only as a sanity-check denominator -->
- **clustering_method:**
- **minimum_blocker_threshold:** 3

---

## Sub-split verification

<!-- INSTRUCTION: Self-audit BEFORE listing any blocker. Every "no" is a
hard blocker on this file — if any answer below is "no", the sub-split
rule is being violated and the analysis must be redone. -->

- All source respondents are Somewhat Disappointed: <!-- yes/no -->
- All source respondents passed the main-benefit resonance check: <!-- yes/no -->
- No Not Disappointed respondent contributed: <!-- yes/no -->
- No lost-cause Somewhat respondent contributed: <!-- yes/no -->
- Every respondent ID listed below is traceable to pmf-survey-responses.jsonl with `sub_split_main_benefit_resonance: yes`: <!-- yes/no -->

---

## Top Blockers

<!-- INSTRUCTION: Append a new ### Blocker #{N} block for each distinct
blocker. Rank by frequency — Blocker #1 is the most frequently cited.
Minimum 3 blockers recommended. -->

### Blocker #1: {Blocker Name}

- **frequency:** <!-- INSTRUCTION: N of M — e.g. "9 of 22 qualified hopefuls mention this" -->
- **source_annotation:** <!-- INSTRUCTION: comma-separated respondent IDs. Every ID must have been verified to pass the sub-split filter. -->
- **paraphrased example quotes (NOT verbatim):**
  - "..."
  - "..."
- **potential unblock approach:** <!-- INSTRUCTION: preliminary idea for the roadmap — one or two sentences on what "unblocking" this blocker might actually mean. Not a commitment; the roadmap file is where commitment happens. -->

---

### Blocker #2: {Blocker Name}

- **frequency:**
- **source_annotation:**
- **paraphrased example quotes (NOT verbatim):**
  - "..."
  - "..."
- **potential unblock approach:**

---

### Blocker #3: {Blocker Name}

- **frequency:**
- **source_annotation:**
- **paraphrased example quotes (NOT verbatim):**
  - "..."
  - "..."
- **potential unblock approach:**

---

<!-- INSTRUCTION: Add Blocker #4, #5, etc. as the data supports. Every
blocker must pass the sub-split verification above before it is
written here. -->

## Related files

- `pmf-survey-responses.jsonl` — raw data, including the sub_split_main_benefit_resonance field on each response
- `pmf-segmentation-sheet.md` — confirms the qualified hopefuls count
- `fanatics-why-they-love.md` — the paired analysis for the doubling-down half
- `pmf-roadmap.md` — the unblocking path this file feeds into
- `knowledge/pmf-hopefuls-analysis.md` — the method and the sub-split rationale
