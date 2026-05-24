---
deliverable_type: pmf-survey
status: empty_template
team_required: false
source: rahul_vohra_pmf_engine
last_updated: null
---

# PMF Survey (Sean Ellis Test™ + qualitative follow-ups)

> **Status:** empty_template — to be filled in during Step 1a (survey design)
> **Team-required:** no (solo-OK, optional team input)
> **Source:** Rahul Vohra's PMF Engine methodology

## How to use this file

This file is the design of your survey instrument: the 4 questions in their
final wording, the concrete definition of an engaged user for your product,
and the plan for distribution. It is filled in once at the start of
Implementation Phase, then referenced on every send (initial, monthly
top-up, quarterly refresh). The engaged-user filter and the "never re-survey
the same user" rule are both enforced on this file — see
`pmf-survey-responses.jsonl` for the respondent ID list you filter new sends
against.

## Rules (from the substance rubric)

- **engaged_users_only (non-negotiable):** every send must filter the
  candidate list to users with two or more uses in the last two weeks,
  applied at the moment of dispatch.
- **never_re_survey_same_user (non-negotiable, continuous):** filter the
  candidate list against the respondent ID register in
  `pmf-survey-responses.jsonl` before every send.
- **All 4 questions present:** Q1 uses Sean Ellis wording and the three
  canonical answer options; Q2, Q3, Q4 are free text.
- **Product name inserted:** replace `{PRODUCT_NAME}` in each question with
  the actual product name before sending.

## The 4 Questions

<!-- INSTRUCTION: Fill in {PRODUCT_NAME} consistently across all four
questions. Do not rephrase Q1 — the three answer options (very / somewhat /
not) are the Sean Ellis form and are load-bearing for the benchmark. -->

### Q1 — How would you feel if you could no longer use {PRODUCT_NAME}?

- [ ] Very disappointed
- [ ] Somewhat disappointed
- [ ] Not disappointed (it isn't really useful)

### Q2 — What type of person do you think would benefit most from {PRODUCT_NAME}?

<!-- INSTRUCTION: Free-text field. This is the mirror question — the
answers will describe the respondent themselves and will feed the HXC™
persona when filtered to Very Disappointed respondents only. -->

### Q3 — What is the main benefit you personally get from {PRODUCT_NAME}?

<!-- INSTRUCTION: Free-text field. Feeds the fanatics analysis when
filtered to Very Disappointed, and feeds the main-benefit-resonance
sub-split on Somewhat Disappointed. -->

### Q4 — How can we improve {PRODUCT_NAME} for you?

<!-- INSTRUCTION: Free-text field. Feeds both fanatics patterns (Very
Disappointed) and hopefuls blockers (Somewhat Disappointed with main-
benefit resonance). -->

## Engaged User Filter Definition

<!-- INSTRUCTION: Define what "two uses in the last two weeks" concretely
means for this product. Name the event, the query, the data source, and
the owner of the query. The filter must be re-applied on every send, not
only the first one. -->

- **Product-specific definition of "use":**
- **Data source / query:**
- **Query owner:**
- **Filter re-run cadence:** every send, no exceptions

## Distribution Plan

<!-- INSTRUCTION: Fill in the dispatch channel, the candidate pool, and
the target sample size. Aim for at least 40 completed responses for a
trustworthy benchmark read; 15-39 is directional only; below 15 keep
collecting. -->

- **Channel (email / in-app / other):**
- **Audience list source:**
- **Target sample size:** ≥ 40 completed responses (benchmark reading)
- **Expected response rate:**
- **Scheduled send window:**

## Respondent Tracking

<!-- INSTRUCTION: Every send must be filtered against the respondent ID
register in pmf-survey-responses.jsonl. The "never re-survey the same user"
rule is continuous, non-negotiable, and applies to every monthly and
quarterly refresh as well as the initial send. -->

- **Respondent ID register file:** `pmf-survey-responses.jsonl`
- **Pre-send filter confirmed (yes/no):**
- **Engagement filter applied on this send (yes/no):**

## Related files

- `knowledge/pmf-sean-ellis-test.md` — why the wording and options matter
- `pmf-survey-responses.jsonl` — append-only response store and ID register
- `pmf-score-history.jsonl` — where the computed score lands
- `rules/rules.md` — the non-negotiables this file enforces
