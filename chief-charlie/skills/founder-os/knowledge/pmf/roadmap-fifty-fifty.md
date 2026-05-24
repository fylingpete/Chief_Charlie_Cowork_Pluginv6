---
source: rahul_vohra
source_type: article
source_id: superhuman-pmf-engine
source_title: "How Superhuman Built an Engine to Find Product-Market Fit"
source_chapter: "First Round Review, 2018"
source_url: "https://review.firstround.com/how-superhuman-built-an-engine-to-find-product-market-fit/"
domain: execution
sub_topic: fifty-fifty-roadmap
stage: [implementation, operating]
problem: [stagnant-score, unbalanced-roadmap, feature-parity-trap, politics-driven-prioritization]
action_type: framework
key_insight: "Approximately half of roadmap capacity doubles down on the patterns the fanatics love, and approximately half unblocks the frictions holding qualified hopefuls back. Both halves are needed; neither alone moves the number. Cost/impact stacking prioritizes within each half."
language: en
date_added: 2026-04-15
---

# The 50/50 Roadmap Split

The 50/50 Roadmap Split is Rahul Vohra's strategic invariant for turning
survey analysis into shipped work. Inside the PMF Engine he assembled at
Superhuman®, it is the single decision rule that governs how the quarter's
capacity is allocated: roughly half of the available work goes to doubling
down on the patterns the Fanatics love, and roughly half goes to
unblocking the specific frictions raised by the qualified Hopefuls. The
rule is deliberately strict. It is not 80/20, not 100/0, and not "whatever
feels right this quarter." The balance itself is the mechanism by which
the very-disappointed percentage moves.

## The 50/50 principle

The principle rests on a simple claim: the users who already love the
product and the users who are close to loving it are two different
audiences with two different needs, and a roadmap that only serves one of
them cannot move the benchmark. Doubling down makes the Fanatics love the
product more deeply. Unblocking converts Hopefuls into Fanatics by
removing whatever is currently preventing them from crossing into the
Very Disappointed bucket on the next survey. Both moves increase the
Very Disappointed percentage, but through different mechanisms.

Rahul is explicit that neither extreme works on its own:

- **If you only double down**, the benchmark tends to stagnate. The
  Fanatics are already Fanatics — they are already choosing the top box.
  Making them even happier does not move the percentage because they
  cannot choose a higher box than the one they already chose. Meanwhile,
  the Hopefuls stay blocked by whatever was blocking them, and they never
  convert. The top box gets deeper but no wider.
- **If you only unblock**, the benchmark tends to erode. The roadmap
  turns into a feature-parity sprint against competitors, the core
  differentiators stop receiving investment, and the things that made the
  Fanatics fanatic in the first place gradually weaken. The top box gets
  wider but shallower, and eventually shallower wins out over wider.

The 50/50 split is the balance point at which both mechanisms are
working. A tolerance of 40/60 to 60/40 is acceptable in practice.
Anything outside that band fails the non-negotiable check and must be
explicitly bypassed.

## Where the initiatives come from

The two halves have different sources, which is part of what keeps the
split honest:

- **Doubling-down initiatives** come from the fanatics-patterns list
  extracted from Very Disappointed Q3 and Q4 answers. The list is the
  clustered, frequency-counted inventory of what Fanatics say they love
  and what they want more of. Each pattern on the list can seed one or
  more roadmap initiatives that deepen that specific thing.
- **Unblocking initiatives** come from the hopefuls-blockers list
  extracted from sub-split-qualified Somewhat Disappointed Q4 answers.
  The list is the clustered, frequency-counted inventory of the specific
  frictions preventing otherwise-close users from becoming Fanatics.
  Each blocker seeds one or more roadmap initiatives that remove that
  friction.

If either source list is empty or thin, the 50/50 split cannot be
meaningfully built. The skill's recommendation is that at least three
distinct patterns and three distinct blockers are present before the
roadmap is assembled, and the implementation-phase aim is to get to
roughly five initiatives per half once cost/impact stacking has been
applied.

## Cost/impact stacking inside each half

Within each half, initiatives are prioritized on a two-axis grid:
estimated cost and estimated impact, each labeled Low / Medium / High.
The purpose of the grid is not precision — it is transparency. When every
item carries explicit labels, the stack is legible to anyone looking at
the roadmap and arguments about "which should come first" can be grounded
in the labels rather than in whoever is arguing loudest.

The practical reading of the grid:

- **Low cost × High impact = Quick Wins.** These are shipped first, in
  both halves. Quick Wins are the cheapest way to move the benchmark and
  the easiest to defend on a rubric.
- **Medium cost × High impact** and **Low cost × Medium impact** are the
  backbone of each half. These are the items that fill out the quarter.
- **High cost × High impact** items are built if capacity allows and
  time horizon permits. They are deliberately not the default.
- **High cost × Low impact** items are deferred or dropped. A roadmap
  that has several of these is signaling that the cost/impact
  conversation was not taken seriously.

Quick Wins are surfaced across both halves first, then the remaining
capacity is balanced so the overall 50/50 ratio is preserved. In other
words, the priority order is: Quick Wins first (from either half, as
many as exist), then fill in the rest while maintaining balance.

## Minimum depth per half

The rule of thumb is at least five initiatives per half once the roadmap
is assembled. Below five, the half is too thin to survive the quarter —
one slipped initiative cuts the half to four, and a half that drops into
single digits stops being a real half. The "at least three patterns and
three blockers" recommendation at the analysis step is what makes the
"at least five per half" rule achievable at the roadmap step; thin source
lists produce thin roadmap halves.

## Tolerance and the rubric check

The skill applies a 40/60 to 60/40 tolerance band on the allocation
ratio. Within that band, the split is considered balanced and the
rubric check passes. Outside the band, the check fails, and the user is
prompted to either rebalance (by moving items between halves) or
explicitly bypass the non-negotiable with a logged reason. The bypass
protocol exists because there are legitimate situations — a critical
security issue, a platform migration forced by an upstream change — in
which the split genuinely cannot hold for one quarter. The bypass log
records those situations so the pattern is visible over time.

## Criteria / Rules

- Roadmap allocation is within the 40/60 to 60/40 tolerance band.
- Doubling-down initiatives trace back to specific fanatics patterns in
  the pattern list.
- Unblocking initiatives trace back to specific hopefuls blockers in the
  blocker list.
- Every initiative has cost and impact labels.
- Quick Wins (low cost × high impact) are identified and scheduled
  first.
- At least five initiatives per half once Quick Wins are exhausted.
- A ratio outside the tolerance band is logged as a bypass with a
  documented reason.

## Common pitfalls

- Defaulting to a roadmap that is almost entirely unblocking because
  Hopefuls feedback is louder and more specific than Fanatics feedback.
- Defaulting to a roadmap that is almost entirely doubling down because
  the team is protective of its differentiators and reluctant to spend
  capacity on "parity" work.
- Skipping cost/impact labels and prioritizing by argument.
- Letting a single very-vocal blocker or a single very-loud fanatic
  pattern consume an entire half.
- Treating the 50/50 rule as a suggestion and sliding to 80/20 without
  noticing.
- Building a thin roadmap (fewer than five initiatives per half) and
  calling it balanced because the ratio is technically correct.

## When to apply

- Step 2 of Implementation Phase, when the first roadmap is being
  assembled from the analysis artifacts.
- Every Quarterly Rebuild, when the roadmap is reassembled from scratch
  on the latest pattern and blocker lists.
- Anytime during the quarter when capacity frees up and new items are
  being added — the added items should preserve the ratio.

## Related blocks

- [pmf-segmentation.md](pmf-segmentation.md) — how Fanatics and
  Hopefuls are identified in the first place.
- [pmf-sean-ellis-test.md](pmf-sean-ellis-test.md) — the benchmark the
  roadmap is ultimately trying to move.
- [pmf-iteration-loop.md](pmf-iteration-loop.md) — why the roadmap is
  rebuilt every quarter rather than set once.
- [pmf-anti-patterns.md](pmf-anti-patterns.md) — the explicit rule
  against 100/0 splits.
