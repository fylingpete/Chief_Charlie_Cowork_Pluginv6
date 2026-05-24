---
source: rahul_vohra
source_type: article
source_id: superhuman-pmf-engine
source_title: "How Superhuman Built an Engine to Find Product-Market Fit"
source_chapter: "First Round Review, 2018"
source_chapter_note: "Framework attributed to Julie Supan, referenced by Rahul Vohra"
source_url: "https://review.firstround.com/how-superhuman-built-an-engine-to-find-product-market-fit/"
domain: analysis
sub_topic: hxc-framework
stage: [implementation, operating]
problem: [fantasy-persona, founder-imagination, wrong-segment-persona]
action_type: framework
key_insight: "The High Expectation Customer is extracted exclusively from Very Disappointed respondents' Q2 and Q3 answers — happy users describe themselves when asked who benefits most, so their answers are a mirror of the target persona rather than a guess about someone else."
language: en
date_added: 2026-04-15
---

# The High Expectation Customer Framework

The High Expectation Customer™ framework (Julie Supan) — abbreviated HXC
throughout the rest of this file — is the persona method Rahul Vohra
adopted for the PMF Engine while building Superhuman®. The HXC answers
the question "for whom are we building" with a concrete, named character
rather than a demographic slice. The critical methodological point is
where the persona is extracted from: not from founder intuition, not from
the marketing team's existing segmentation decks, not from the entire
survey respondent pool, but exclusively from the Q2 and Q3 answers given
by Very Disappointed respondents. Everything else in the skill — the
roadmap split, the doubling-down priorities, the tone of messaging and
positioning — hangs off the persona this framework produces, which makes
the extraction discipline load-bearing.

## Attribution to Julie Supan

The HXC framework is attributed to Julie Supan, who developed and applied
it during her branding work with several well-known companies including
Airbnb, Dropbox, YouTube, and Thumbtack. Rahul references her framework
explicitly in the article and uses it as the persona engine for the PMF
methodology. Attribution accompanies the first mention in any file that
introduces the HXC.

Julie Supan's framing treats the persona as a description of the most
demanding and enthusiastic customer the product could serve — the user
who will notice every detail and feel every friction — rather than as a
statistical average of "typical users." The insight that makes the
framework work inside a PMF measurement system is that this high-
expectation character is not imagined: it is the character who shows up
in the Very Disappointed bucket on the Sean Ellis Test™ (Sean Ellis),
because those
are the users who genuinely feel the core value.

## The key insight — happy users describe themselves

The mechanism that turns the HXC framework into an extraction method
rather than a guessing game is a simple behavioral observation: when you
ask a happy user who else would benefit from the product, they describe
themselves. Their answer to Q2 ("what kind of person do you think would
get the most value from this product?") is not a prediction about
strangers — it is an indirect self-portrait. The user who writes "someone
who does X, cares about Y, and gets frustrated by Z" is almost always
describing their own life and framing it as if they were talking about a
hypothetical peer.

Combine that with Q3, in which the same user directly says what the main
benefit is that they personally get from the product, and you have two
complementary streams of self-description: one indirect and one direct.
Read together across the whole Very Disappointed pool, they produce a
composite portrait of the kind of person who is already falling in love
with the product. That portrait is the HXC.

## Extraction method

The extraction is mechanical and honest. It does not involve founder
interpretation of what the user "really meant":

1. Filter to Very Disappointed respondents only. Every other segment is
   excluded from this step. Not Disappointed is excluded by rule. Somewhat
   Disappointed — even the sub-split-qualified hopefuls — is excluded
   because their persona signal is diluted by the frictions that are
   currently blocking them.
2. Pull every Q2 answer from this filtered set. Read them looking for
   patterns in role, context, work environment, and the type of person
   being described. Cluster recurring language.
3. Pull every Q3 answer from the same filtered set. Read them looking
   for patterns in the main benefit being felt. Cluster recurring
   language.
4. Combine the two clustered reads into a composite picture. The Q2
   clusters tell you who the user is; the Q3 clusters tell you what they
   feel the product does for them.
5. Write the persona as a concrete character — preferably with a name
   — with specific fields filled in (see below).

No step in this extraction allows founder imagination. The founder's job
during extraction is to read honestly and cluster accurately, not to add
aspirational details or smooth over surprises.

## Required fields of the HXC

A complete HXC is concrete enough to feel recognizable. It has at minimum:

- **Name.** A specific first name (or first-and-last) so the team has a
  shared referent. "Our HXC" is abstract; a named character is coordinating.
- **Role or title.** The kind of job the user holds, in the vocabulary
  the users themselves use in Q2.
- **Work context.** The environment in which the product gets used —
  team size, cadence, constraints, surrounding tools.
- **Main benefit felt.** The payoff the user describes in Q3 — the thing
  they are getting from the product that they would actually mourn if it
  disappeared.
- **Frustration or desire.** The pain the product is relieving, or the
  outcome the product is unlocking — as expressed by real respondents in
  the Very Disappointed pool, not as imagined by the team.

The persona reads as a paragraph-length description of a single
character. It is not a bullet list of demographic slices, and it is not a
"target segment." It is one person.

## Why founder imagination is not allowed

Founder imagination is a fast and destructive shortcut. The persona that
emerges from imagination is always a flattering version of the user the
founder wishes existed — smarter, more sophisticated, more enthusiastic,
more lucrative — rather than the user who is actually in the Very
Disappointed bucket this quarter. A roadmap built for an imagined user
spends its capacity on features that an imagined user would love and that
real users will never notice. The measurement loop then fails to move
because the team has optimized for the wrong character.

The HXC framework solves this by forcing the extraction to come from
user words, on a segment that is explicitly defined, using fields that
can be traced back to specific responses. It is an unusually disciplined
method precisely because the alternative is so easy and so wrong.

## Versioning — lock at Step 3, re-profile quarterly

The HXC is not a permanent artifact. It is a snapshot of who the
fanatics are right now. As the product evolves and the user base shifts,
the character in the Very Disappointed bucket will also shift, and the
persona needs to keep up. The skill handles this with two discipline
points:

- **Lock at end of Step 3.** The HXC is given an explicit version marker
  (for example `v1-locked`) when Implementation Phase closes. That frozen
  version becomes the reference point for every Weekly Check-In and Monthly
  Measurement in the current quarter.
- **Re-profile at Quarterly Rebuild.** Every quarter, the Very
  Disappointed pool is re-read against new responses, and the HXC is
  either re-confirmed (if the demographics and benefit patterns still
  hold) or intentionally updated to a new version. A rebuild that moves
  the persona is a real event and is recorded as such in the state file.

Without the version marker, quarterly re-profiling cannot distinguish
between intentional updates and accidental drift, and team conversations
about "the HXC" lose their anchor.

## Anti-pattern — building the HXC from the whole pool

The single most common failure mode is extracting the persona from all
respondents instead of only from Very Disappointed. This feels more
"data-driven" because it uses more responses, but it is actively
misleading. Including Somewhat Disappointed dilutes the persona with
users whose relationship to the product is shaped by the specific
frictions currently blocking them. Including Not Disappointed dilutes it
further with users who do not feel the core value at all. The composite
that emerges is a portrait of the average user, not a portrait of the
user who loves the product — and the whole point of the HXC is to
describe the loving user, not the average one.

A related anti-pattern is building the HXC from interviews, usability
studies, or any other source that is not the four-question survey. Those
sources are valuable for other things, but they are not filtered on the
Very Disappointed condition and they cannot take its place.

## Criteria / Rules

- HXC is built from Very Disappointed respondents only. No exceptions.
- Q2 and Q3 are the only two input fields. Q1 is used for segment
  membership; Q4 feeds fanatics patterns, not the persona.
- The persona has a concrete name.
- Required fields are filled in with material that can be traced back to
  specific respondent quotes (paraphrased).
- The HXC carries an explicit version marker at the close of
  Implementation Phase.
- Founder intuition, pre-existing marketing personas, and interview-only
  sources are not permitted as inputs.

## Common pitfalls

- Building the persona from the whole respondent pool because it has
  "more data."
- Letting the founder's mental image of "who we are building for" leak
  into the persona write-up.
- Skipping the name and leaving the persona as an abstract description.
- Extracting Q2 and Q3 by skimming rather than by clustering, so the
  persona reflects the loudest three responses.
- Failing to version-lock the HXC at the end of Step 3, which leaves the
  quarterly rebuild with nothing to compare against.

## When to apply

- Step 1 of Implementation Phase, when the user is reading Very
  Disappointed responses for the first time.
- Step 3 of Implementation Phase, when the persona is version-locked.
- Quarterly Rebuild, when the persona is re-read against new responses
  and either confirmed or updated.

## Related blocks

- [pmf-segmentation.md](pmf-segmentation.md) — how Very Disappointed
  is identified in the first place.
- [pmf-sean-ellis-test.md](pmf-sean-ellis-test.md) — the Q2 and Q3
  wording that produces the raw material.
- [pmf-iteration-loop.md](pmf-iteration-loop.md) — why the persona is
  re-profiled every quarter rather than locked forever.
- [pmf-anti-patterns.md](pmf-anti-patterns.md) — the explicit rule
  against building the HXC from anything other than Very Disappointed.
