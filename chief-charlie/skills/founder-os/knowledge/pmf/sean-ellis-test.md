---
source: rahul_vohra
source_type: article
source_id: superhuman-pmf-engine
source_title: "How Superhuman Built an Engine to Find Product-Market Fit"
source_chapter: "First Round Review, 2018"
source_url: "https://review.firstround.com/how-superhuman-built-an-engine-to-find-product-market-fit/"
domain: measurement
sub_topic: sean-ellis-test
stage: [implementation, operating]
problem: [no-pmf-measurement, missing-benchmark, unreliable-sample]
action_type: tool
key_insight: "One question asked of engaged users — how they would feel if the product went away — with at or above 40% 'very disappointed' as the working benchmark for strong product-market fit."
language: en
date_added: 2026-04-15
---

# The Sean Ellis Test and the 40% Benchmark

The Sean Ellis Test™ (Sean Ellis) is the measurement mechanic at the
center of Rahul Vohra's PMF Engine. It is a single question asked of
engaged users that produces a single number, and that number is compared
against a working benchmark — the Sean Ellis 40% Rule™ — to determine
whether the product has strong product-market fit or not yet. Everything
else in the methodology — segmentation, persona extraction, the roadmap
split, the iteration loop — is built on top of this one reading. Rahul
adopted it for Superhuman® because it was the only instrument he could
find that produced a leading indicator on a timescale short enough to
actually iterate on.

## The one question and the three answer options

Respondents are asked, in the skill's paraphrased form, how they would
feel if they could no longer use the product. They choose one of three
options:

- **Very Disappointed**
- **Somewhat Disappointed**
- **Not Disappointed**

The share of respondents who pick the strongest option — Very
Disappointed — is the number that gets tracked. A respondent who chooses
Somewhat is not "half a Very." The test treats the top box as the only box
that counts toward the benchmark, and treats the other two as inputs to
segmentation rather than as partial credit. This top-box orientation is
what makes the metric sensitive to genuine attachment rather than to polite
satisfaction.

## Why 40%

The benchmark is attributed to Sean Ellis's earlier research, in which he
examined roughly one hundred consumer-software startups and found that the
companies whose Very Disappointed share sat at or above forty percent
tended to grow durably, while the companies sitting below that line
tended to stall. The line is therefore empirically anchored rather than
pulled out of the air. In the skill, it is treated as a working benchmark
— a target with enough support behind it to function as an operating
metric — rather than as a magic threshold that flips a binary state.
Teams under the line are not "broken"; they are below the observed growth
inflection and should be iterating. Teams at or above the line still keep
measuring.

## Attribution

The test and the benchmark both originate with Sean Ellis. Rahul Vohra
adopted them wholesale in the PMF Engine and layered additional structure
on top. The name of the instrument in this skill is Sean Ellis Test, and
the forty-percent line is the Sean Ellis 40% Rule. Attribution to Sean
Ellis accompanies the first mention in any file that introduces the test.

## The four-question survey

Rahul does not use the Sean Ellis question in isolation. He bolts three
qualitative questions onto it to produce a four-question instrument. The
quantitative answer tells the team where they are; the qualitative answers
tell the team what to do next. The four questions are:

- **Q1 (quantitative, Sean Ellis):** How would you feel if you could no
  longer use the product? (Very Disappointed / Somewhat Disappointed / Not
  Disappointed)
- **Q2 (who benefits most):** What kind of person do you think would get
  the most value from this product?
- **Q3 (main benefit):** What is the main benefit you personally get from
  the product?
- **Q4 (improvement):** How could the product be improved for you?

Q1 produces the benchmark number. Q2 and Q3, read on the Very Disappointed
segment, produce the raw material for the High Expectation Customer™
(Julie Supan)
persona. Q3 on the Somewhat Disappointed segment is used for the sub-split
that separates convertible hopefuls from lost causes. Q4 on the qualified
hopefuls produces the list of blockers that feeds the unblocking half of
the roadmap. The four questions are not independent pieces; they are a
single coupled instrument.

## Who to send the survey to

The survey is only ever sent to engaged users. The working definition in
the article is users who have logged at least two sessions in the last two
weeks. The exact numbers can be adapted to a product with a different
usage rhythm — a weekly tool and a daily tool will have different
"engaged" definitions — but the principle is not negotiable: a respondent
who has not recently used the product cannot give a considered reaction
to the current product experience. Their answer reflects absence, not
attachment, and it contaminates the benchmark.

## Sample size guidance

The forty-percent benchmark is only meaningful on a sample that is large
enough to stabilize. The skill uses three bands:

- **At least 40 completed responses** — benchmark-valid. The Very
  Disappointed percentage can be read against the forty-percent line
  with confidence.
- **15 to 39 completed responses** — directional only. The qualitative
  work (persona, patterns, blockers) is still useful, but the benchmark
  reading should not be treated as stable. Continue collecting.
- **Fewer than 15 completed responses** — continue collecting. Do not
  draw conclusions from the percentage yet, and flag the state explicitly
  so downstream analysis is not built on a foundation that is too thin.

Small samples swing wildly and invite over-reading of noise. The bands
exist so the team is honest with itself about which mode it is in.

## Criteria / Rules

- Q1 uses the Sean Ellis wording and exactly the three answer options.
  Five-point scales, emoji scales, and extra options are not equivalent.
- The survey is sent only to engaged users, where "engaged" is defined
  for the product and documented.
- The Very Disappointed percentage is calculated on completed responses,
  not on sent-to counts.
- Sample size band is recorded with the reading so downstream interpretation
  knows whether the number is benchmark-valid or directional only.
- The same user is never surveyed twice (see pmf-anti-patterns.md).

## Common pitfalls

- Sending the survey to the entire user list, including dormant users,
  because it is easier than filtering. The benchmark is destroyed by
  including absence responses.
- Substituting a five-point or ten-point scale and then mapping it back
  to the three canonical answers. The translation is never clean and the
  benchmark line does not survive the change.
- Reading a percentage off a sample of eight respondents and celebrating
  or panicking based on the result.
- Dropping Q2, Q3, or Q4 because "the number is what matters." Without the
  qualitative questions there is no way to build a persona or a roadmap,
  and the number becomes a thermometer with no treatment plan.
- Asking the question of users who just signed up and have not yet had a
  chance to form an opinion.

## When to apply

- Implementation Phase Step 1 — when the user is designing their first
  survey send and needs to understand the instrument.
- Weekly Check-In and Monthly Review cadences — when the user is
  reviewing new readings and needs a reference for what the bands mean.
- Anytime the user proposes a variant of the question and needs to
  understand why the canonical form is load-bearing.

## Related blocks

- [pmf-why-measure.md](pmf-why-measure.md) — why a number is better than
  a feeling in the first place.
- [pmf-segmentation.md](pmf-segmentation.md) — how the three answer
  options become three strategic segments.
- [pmf-hxc-framework.md](pmf-hxc-framework.md) — how Q2 and Q3 on the top
  segment become the persona.
- [pmf-anti-patterns.md](pmf-anti-patterns.md) — the engaged-users-only
  and never-re-survey rules that protect the reading.
