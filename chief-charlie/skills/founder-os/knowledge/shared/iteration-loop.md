---
source: rahul_vohra
source_type: article
source_id: superhuman-pmf-engine
source_title: "How Superhuman Built an Engine to Find Product-Market Fit"
source_chapter: "First Round Review, 2018"
source_url: "https://review.firstround.com/how-superhuman-built-an-engine-to-find-product-market-fit/"
domain: operating
sub_topic: iteration-loop
stage: [operating]
problem: [one-shot-thinking, post-pmf-complacency, stale-persona, drift]
action_type: discipline
key_insight: "Product-market fit is not a one-shot achievement. It is a metric tracked on weekly, monthly, and quarterly cadences, with a full rebuild each quarter. The iteration loop does not stop when the benchmark is crossed."
language: en
date_added: 2026-04-15
---

# The Iteration Loop

Rahul Vohra's PMF Engine, built during his work on Superhuman®, is not a
one-shot diagnostic that the team runs once and then files away. The
measurement it produces — the Very Disappointed percentage from the Sean
Ellis Test™ (Sean Ellis) — is treated as an ongoing operating metric,
refreshed on cadence and rebuilt from scratch every quarter. The
iteration loop is the part of the methodology that turns measurement
from a one-off exercise into a discipline. Running the Engine once and
then moving on is the same mistake as measuring body weight once and
assuming you know your weight for life: the number only tells you where
you are at the moment it is read, and the whole point is to read it
repeatedly and move it.

## Why continuous measurement

Three things change continuously and push the number around regardless
of what the team does:

- **The user base shifts.** As the product grows, the composition of
  the active user pool changes. New users from new acquisition channels
  enter with different expectations. Tenured users evolve their use of
  the product. A persona that was accurate last quarter can drift into
  inaccuracy by the next one.
- **The product evolves.** Each release changes the product experience.
  Features ship. Frictions get removed. Other frictions get introduced
  by accident. The thing users are reacting to in Q1 of the survey is
  not the same thing they were reacting to three months ago.
- **The market moves.** Competitors release things. Categories get
  redefined. Expectations rise. The same product that scored above the
  benchmark a year ago can slide below it without the team touching any
  code, simply because the surrounding context has changed.

A one-shot measurement cannot catch any of these. A continuous
measurement — running on a defined cadence and compared against prior
readings — catches all of them.

## The three cadences in this skill

The skill operationalizes the iteration loop with three nested cadences,
each answering a different question:

- **Weekly Check-In.** The fastest loop. New responses from newly-engaged
  users are read, the Very Disappointed percentage is refreshed, and
  early trend shifts are noticed before they compound. The Weekly
  Check-In is not a full rebuild; it is a check on the instrument. If the
  number moves unexpectedly, the check-in surfaces it immediately rather
  than letting the team discover the drift a month later.
- **Monthly Review.** The medium loop. A structured review of the
  past month's responses, segmented and re-analyzed at the block level
  — how is the V/S/N split trending, are any new patterns emerging in
  the Q4 write-ups, are any hopefuls blockers reappearing that should
  have been closed by recent work. The monthly review feeds the
  quarterly rebuild with a running log of observations rather than a
  raw pile of responses.
- **Quarterly Rebuild.** The deep loop. The full analysis pipeline is
  re-run from scratch on the latest responses. The V/S/N segmentation
  is redone. The High Expectation Customer™ persona (Julie Supan) —
  abbreviated HXC throughout the rest of this file — is re-read against
  the current Very
  Disappointed pool and either re-confirmed or intentionally updated.
  The fanatics patterns and hopefuls blockers lists are rebuilt. The
  roadmap for the next quarter is allocated from the new lists using
  the 50/50 split. The Quarterly Rebuild is the heart of the loop; the
  weekly and monthly touches exist to keep the quarterly moment honest.

Each cadence loads a subset of the skill's knowledge blocks and produces
a subset of the artifacts. The Weekly Check-In is lightweight; the
Quarterly Rebuild is the heavy lift.

## How new engaged users enter the survey pool

The survey pool grows naturally as more users cross the engagement
threshold — the working definition is users who have used the product
at least twice in the last two weeks — without the team re-surveying
anyone who has already responded. Each cadence check identifies users
who newly qualify as engaged, have not previously responded, and can
therefore be sent the survey for the first time. This is how the pool
stays fresh without contaminating the benchmark.

The discipline is quietly important. A team that re-surveys old
respondents to "get more data" is trading the integrity of the benchmark
for a short-term volume bump, and the trade is a bad one: the new
readings reflect a user's second thoughts rather than their honest first
reaction, and the historical comparability of the metric is lost.

## The "never re-survey the same user" discipline

The prohibition on re-surveying is not a style preference — it is a
direct consequence of how the Sean Ellis benchmark was calibrated. The
original research asked users for a first-reaction answer. Any
methodology that wants to read its results against that benchmark must
replicate the first-reaction condition. A returning respondent's second
answer is not a first reaction; it is a second reaction shaped by
everything they remember from the first one, and it cannot be compared
against the benchmark on equal terms.

The practical implementation is to track respondent identifiers for
every completed response and to filter those identifiers out of every
future send list. The filter is applied at every send — weekly, monthly,
quarterly — not just at the first one. New engaged users that have
never responded are added to the send list; previous respondents are
excluded permanently.

## Rahul's trajectory — the shape of the journey

Rahul's article reports his own team's trajectory across several
quarters. The specific percentages he cites are intentionally not
reproduced in this skill. The transferable observation is the shape of
the journey: a starting measurement below the benchmark, a rise after
the first pass of segmentation and targeted work, further rises as
additional quarterly rebuilds reflected fresh analysis, and eventually a
crossing of the benchmark followed by continued climb. The useful
lesson for a user running the skill is that the benchmark is usually not
crossed in one quarter. It is crossed over multiple quarters of running
the full loop, and each quarter contributes a measurable step.

## The milestone is not the end

Crossing the forty-percent line is a milestone, not a termination
condition. The team that stops measuring after the first strong reading
is the team that watches the number drift without noticing. The user
base keeps shifting, the product keeps evolving, the market keeps
moving — and without a live reading, the team does not learn that it
has slipped back below the line until the downstream lagging signals
(retention, revenue) finally catch up months later. The iteration loop
therefore continues past the milestone. Weekly Check-In, Monthly
Measurement, and Quarterly Rebuild all keep running.

## Why Quarterly Rebuild exists

The quarterly cadence is heavier than the weekly and monthly cadences
because it is the only cadence that re-profiles the persona and
re-allocates the roadmap from scratch. In between rebuilds, the HXC
stays locked, the pattern and blocker lists stay frozen, and the
roadmap executes on those inputs. The Quarterly Rebuild is the moment
at which the question "are we still building for the right person and
against the right friction?" gets asked in earnest. Without it, the
skill would optimize against a snapshot that slowly goes out of date.

Concretely, the Quarterly Rebuild:

- Re-segments the latest responses.
- Re-extracts the HXC from the current Very Disappointed pool and
  decides whether to re-confirm or update the persona version.
- Rebuilds the fanatics patterns list and the hopefuls blockers list.
- Allocates the next quarter's roadmap using the 50/50 split and
  cost/impact stacking.
- Records everything in the state file so the history of the engine
  is auditable quarter-over-quarter.

## Criteria / Rules

- Weekly Check-In, Monthly Review, and Quarterly Rebuild cadences are
  all active and on the calendar.
- No respondent is ever sent the survey more than once; respondent
  identifiers are tracked and filtered.
- The engagement filter is applied at every send, not just the first.
- The Quarterly Rebuild rebuilds the persona, patterns, blockers, and
  roadmap from scratch on the latest responses.
- Iteration continues after the benchmark is crossed.

## Common pitfalls

- Running the full method once and then treating it as "done."
- Stopping measurement after the first reading above forty percent on
  the grounds that "we have PMF now."
- Re-surveying existing respondents to boost response counts.
- Letting the HXC persona drift quarter after quarter without ever
  being formally re-profiled or updated.
- Treating Weekly Check-In and Monthly Review as optional and only
  doing Quarterly Rebuilds, which means drift goes unnoticed for up to
  three months.
- Rebuilding the roadmap quarterly but leaving the persona and pattern
  lists from two quarters ago untouched because "they still look
  right."

## When to apply

- Operating Mode — this block is the anchor for the skill's
  post-implementation operating loop.
- First Quarterly Rebuild — to establish the rebuild discipline
  against the version-locked HXC from Implementation Phase.
- Anytime the user proposes winding down measurement because "the
  number is fine now."

## Related blocks

- [pmf-sean-ellis-test.md](pmf-sean-ellis-test.md) — the instrument
  that is being read on each cadence.
- [pmf-hxc-framework.md](pmf-hxc-framework.md) — the persona that is
  re-profiled on each Quarterly Rebuild.
- [pmf-roadmap-fifty-fifty.md](pmf-roadmap-fifty-fifty.md) — the
  roadmap that is rebuilt on each Quarterly Rebuild.
- [pmf-anti-patterns.md](pmf-anti-patterns.md) — the never-re-survey
  and engaged-users-only rules that protect the integrity of the
  iteration loop.
