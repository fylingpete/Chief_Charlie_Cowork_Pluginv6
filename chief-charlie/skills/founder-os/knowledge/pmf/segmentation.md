---
source: rahul_vohra
source_type: article
source_id: superhuman-pmf-engine
source_title: "How Superhuman Built an Engine to Find Product-Market Fit"
source_chapter: "First Round Review, 2018"
source_url: "https://review.firstround.com/how-superhuman-built-an-engine-to-find-product-market-fit/"
domain: analysis
sub_topic: segmentation
stage: [implementation, operating]
problem: [undifferentiated-feedback, wrong-users-feeding-roadmap, lost-cause-contamination]
action_type: framework
key_insight: "V/S/N segmentation unlocks the why behind the score; the sub-split at Somewhat Disappointed separates genuinely convertible hopefuls from lost causes; Fanatics vs. Hopefuls is the strategic framing that drives the 50/50 roadmap."
language: en
date_added: 2026-04-15
---

# V/S/N Segmentation and the Sub-Split

The Sean Ellis Test™ (Sean Ellis) produces a single percentage, and a
single percentage is not a plan. What makes the PMF Engine — Rahul
Vohra's methodology from his work on Superhuman® — actually actionable is
the way survey responses are segmented before any qualitative reading is
done. Responses split three ways on Q1 (Very / Somewhat / Not), and the
Somewhat bucket splits a second time on Q3 resonance. Those two cuts are
what separate the users whose voices should drive the roadmap from the
users whose voices would pull it off course. Rahul frames the two
strategic cohorts as Fanatics and Hopefuls — his names for the Very
Disappointed and for the qualified sub-segment of Somewhat Disappointed
respectively.

## The three segments

Each respondent lands in exactly one of three primary buckets based on
their Q1 answer:

- **Very Disappointed (V).** Users who would feel a genuine loss if the
  product disappeared. This is the core of the persona work and the
  source of the "why they love it" patterns.
- **Somewhat Disappointed (S).** Users who would be inconvenienced but
  not devastated. This is the conversion pool — but only a subset of it.
- **Not Disappointed (N).** Users who would shrug and move on. These
  users are set aside for planning purposes.

The three segments are not graded on a single scale — they are three
different strategic situations, and the right action in each is
different. Treating V, S, and N as "more-to-less attached" loses the
point. V is a persona and a doubling-down target. S is a conversion
problem with a further filter applied. N is a source of noise in the
planning process.

## What each group tells you and what to do with it

**Very Disappointed — build the persona, mine the patterns.** This is
the group whose Q2 and Q3 answers become the High Expectation Customer™
persona (Julie Supan), and whose Q3 and Q4 answers become the fanatics
patterns (the
"why they love it" list). The whole of the "doubling down" half of the
roadmap is sourced from this group. Feedback from Very Disappointed
users is weighted more heavily than feedback from anywhere else, because
they are the ones who already feel the core value.

**Somewhat Disappointed — sub-split first, then mine the qualified
half.** The Somewhat bucket is not used whole. It is further split on
whether the respondent's Q3 answer resonates with the product's actual
core promise. Only the resonant half — the qualified hopefuls — is used
for blocker analysis. The other half is excluded.

**Not Disappointed — thank them and set the feedback aside.** The rule
for this group is polite disregard: accept their input courteously, but
do not filter it into the planning process. Acting on feedback from
users who do not feel the core value drags the roadmap toward surface
area that will never produce strong attachment.

## The critical sub-split at Somewhat Disappointed

The sub-split is the most delicate piece of segmentation in the whole
method, and the one most often skipped. The question it answers is
simple: among users who would be "a little disappointed," who is
actually close to becoming a fanatic, and who is just using the product
for reasons that have nothing to do with the core promise?

The test is Q3. Read the user's main-benefit answer and compare it
against the product's real core promise.

- **Q3 resonates with the core promise** — the user feels the right
  thing but is not yet feeling it strongly enough. Something is
  specifically blocking them from the fullest experience. These are the
  qualified hopefuls. Their Q4 answers become the blocker list.
- **Q3 does not resonate with the core promise** — the user is
  effectively looking for a different product. They may be using the
  tool, even paying for it, but their reason for being there is
  orthogonal to the core value the product is actually designed to
  deliver. These respondents are treated as a lost cause for roadmap
  purposes and excluded from the qualified hopefuls pool.

The sub-split is not about judging users. It is about protecting the
roadmap from optimizing for people who will never move into the Very
Disappointed bucket no matter what is built. A blocker raised by a
lost-cause respondent does not "also help the qualified hopefuls";
mixing the two groups dilutes the signal and makes the blocker list
unreliable.

## Fanatics and Hopefuls — the strategic framing

Rahul's working vocabulary for the two cohorts that matter is Fanatics
and Hopefuls. The mapping is:

- **Fanatics** = Very Disappointed respondents. The users who already
  love the product and would feel the loss if it disappeared.
- **Hopefuls** = the sub-split-qualified half of Somewhat Disappointed.
  The users who feel the right thing but are held back by specific
  friction.

These two groups are the audiences for the two halves of the roadmap.
Fanatics drive the doubling-down half; Hopefuls drive the unblocking
half. If the segmentation goes wrong at any point — wrong bucket
assignment, skipped sub-split, lost causes mixed in with hopefuls — the
roadmap downstream inherits the error and the measurement next quarter
will reflect it.

## How to classify a response

The classification is mechanical and should be done before any
qualitative reading:

1. Read Q1. Assign the respondent to V, S, or N.
2. If the respondent is S, read Q3 and check resonance with the core
   promise. Mark S-resonant (qualified hopeful) or S-nonresonant (lost
   cause).
3. V respondents flow into the persona extraction pool and the fanatics
   pattern pool.
4. S-resonant respondents flow into the hopefuls blocker pool.
5. S-nonresonant respondents are tagged and excluded from roadmap
   analysis.
6. N respondents are tagged "politely disregarded" and excluded from
   roadmap analysis.

Recording the segmentation explicitly (rather than deciding segment
membership in the analyst's head while reading the free text) is what
makes the method defensible later, when the state file needs to show
where each roadmap input came from.

## Anti-pattern: mixing segments in analysis

The most common failure mode is treating all responses as one pool and
reading Q3 / Q4 across the whole set looking for "themes." This produces
a theme list that is a blend of everything — what fanatics love, what
hopefuls are blocked by, what lost causes are looking for, and what the
not-disappointed group finds mildly annoying. The blended list is a
coherent-looking artifact that moves the roadmap in the wrong direction,
because it is optimized for everyone except the users who matter. The
discipline is to segment first, then analyze each segment separately,
then combine only at the roadmap-assembly step.

A sibling anti-pattern is pulling blockers from the S-nonresonant half
by accident. This happens when the sub-split is performed but the
qualified and unqualified sides are kept in the same file and later
analyzed together. The fix is to physically separate the two sub-groups
into different buckets from the moment the sub-split is done.

## Criteria / Rules

- Every response is tagged with a primary segment (V / S / N) before
  analysis begins.
- Every S-tagged response is additionally tagged S-resonant or
  S-nonresonant based on Q3.
- Persona and fanatics patterns come only from V.
- Hopefuls blockers come only from S-resonant.
- N responses are excluded from all roadmap-relevant analysis.
- S-nonresonant responses are excluded from all roadmap-relevant
  analysis.

## Common pitfalls

- Skipping the sub-split and treating all Somewhat Disappointed
  respondents as a single hopefuls pool.
- Letting S-nonresonant responses leak into the blocker list because
  their Q4 answers "sound reasonable."
- Quietly including Not Disappointed Q4 answers in the blocker list on
  the grounds that feedback is feedback.
- Conflating V and S-resonant in persona work, which dilutes the persona
  with users who do not yet feel the full core value.
- Running segmentation informally in the analyst's head rather than
  explicitly tagging each response.

## When to apply

- Step 1 of Implementation Phase, when responses are first being read.
- Every Monthly Review and Quarterly Rebuild, on the new wave of
  responses collected since the last rebuild.
- Whenever the user proposes reading "all the feedback together" and
  needs to be redirected to segmented analysis.

## Related blocks

- [pmf-sean-ellis-test.md](pmf-sean-ellis-test.md) — the four-question
  instrument whose answers feed segmentation.
- [pmf-hxc-framework.md](pmf-hxc-framework.md) — how V-segment Q2 and
  Q3 become the persona.
- [pmf-roadmap-fifty-fifty.md](pmf-roadmap-fifty-fifty.md) — how the
  two qualified cohorts drive the two halves of the roadmap.
- [pmf-anti-patterns.md](pmf-anti-patterns.md) — the explicit rules
  that protect segmentation integrity.
