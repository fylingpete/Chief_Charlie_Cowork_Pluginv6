---
source: rahul_vohra
source_type: article
source_id: superhuman-pmf-engine
source_title: "How Superhuman Built an Engine to Find Product-Market Fit"
source_chapter: "First Round Review, 2018"
source_url: "https://review.firstround.com/how-superhuman-built-an-engine-to-find-product-market-fit/"
domain: meta
sub_topic: anti-patterns
stage: [onboarding, implementation, operating]
problem: [methodology-drift, shortcut-pressure, polluted-benchmark, fantasy-persona, unbalanced-roadmap]
action_type: rule
key_insight: "The PMF Engine is a coupled system of rules. A handful of explicit prohibitions — each traceable to a specific failure mode — protect the measurement from shortcuts that destroy it. Each rule has a one-line statement and a short reason why."
language: en
date_added: 2026-04-15
---

# PMF Engine Anti-Patterns

Rahul Vohra's PMF Engine, built during his work on Superhuman®, is a
coupled system: each piece protects the integrity of the others, and
pulling out any one component breaks the downstream pieces in
predictable ways. This block is the collected inventory of explicit
rules from Rahul's article — the things the method does not allow — each
stated as a one-line prohibition and a short reason why. These rules do
not exist to be strict for the sake of strictness. They exist because
each one protects against a specific failure mode that has been observed
to destroy the measurement when the rule is skipped.

The way this skill applies the rules is documented in the assessment
and rules directories. This knowledge block is the explanatory counterpart:
what the rules are, why they exist, and what breaks when they are
violated.

## 1. Politely disregard Not Disappointed feedback

**The rule.** Feedback from Not Disappointed respondents is accepted
courteously — the user is thanked for their time — and then excluded from
every planning artifact the skill produces. It does not enter the
persona, the fanatics pattern list, the hopefuls blocker list, the
roadmap, or the prioritization conversation.

**Why.** These users do not feel the core value of the product. Their
requests reflect preferences from a user whose attachment to the product
is weak or absent, and acting on those requests drags the roadmap
toward surface area that will never produce strong attachment regardless
of how much is built. A roadmap shaped by Not Disappointed feedback
spends capacity without moving the Very Disappointed percentage, because
the people whose feedback drove it were never going to choose the top
box in the first place.

**What breaks when the rule is skipped.** The benchmark stays flat
despite visible roadmap velocity. The team ships things, users
acknowledge them politely, and the Very Disappointed share does not
move. Worse, the core differentiators — the things the Fanatics love —
start getting underinvested because capacity is going to features that
Not Disappointed users are requesting.

## 2. Engaged users only

**The rule.** The survey is sent exclusively to users who have actually
used the product recently. The working definition from the article is at
least two usage sessions in the past two weeks, adapted to the product's
natural rhythm if needed. Dormant users, trial users who never activated,
and users who signed up and forgot do not receive the survey. The
engagement filter is applied on every send, not just the first.

**Why.** A user who has not recently used the product cannot give a
considered reaction to the current product experience. Their answer
reflects absence — "I don't remember using this" — rather than
attachment. Including those answers in the benchmark produces a reading
that mixes attachment with forgetfulness, and the forty-percent line is
no longer interpretable.

**What breaks when the rule is skipped.** The reading lands wherever
the dormant-to-engaged ratio happens to land that week, and it moves
around when the dormant share changes rather than when the product
changes. The team loses the ability to tell whether roadmap work is
moving the number.

## 3. Never re-survey the same user

**The rule.** Respondent identifiers are tracked for every completed
response and are filtered out of every subsequent send. The same user is
never surveyed a second time, forever.

**Why.** The Sean Ellis benchmark was calibrated against first-reaction
answers. A returning respondent's second answer is shaped by memory of
the first one, not by fresh consideration of the current product
experience. Comparing a second-reaction number against a benchmark built
on first reactions is a category error. The comparison is not valid, and
the history of the metric stops being interpretable if second-reaction
answers creep in.

**What breaks when the rule is skipped.** Historical comparability is
lost. The team can still calculate a number each cadence, but the
numbers no longer mean the same thing across time, and quarterly
trajectories become unreliable. The whole point of the iteration loop —
moving a single comparable metric across quarters — is silently broken.

## 4. The sub-split rule is absolute

**The rule.** Roadmap blockers are sourced exclusively from Somewhat
Disappointed respondents whose Q3 main-benefit answer resonates with the
product's core promise. The sub-split-nonresonant half of the Somewhat
Disappointed bucket is excluded from blocker analysis. Not Disappointed
is also excluded (see rule 1).

**Why.** The sub-split is the only filter that separates users who are
genuinely close to the target from users who are effectively looking for
a different product. The nonresonant half is using the tool for reasons
orthogonal to the core value, and blockers collected from them are
blockers on a journey the team is not trying to build. Mixing the two
halves destroys the commensurability of the blocker list with the
fanatics patterns list — the two sides of the 50/50 roadmap stop
speaking the same language.

**What breaks when the rule is skipped.** The blocker list contains
items that, if shipped, would serve users who will never cross into the
Very Disappointed bucket. The unblocking half of the roadmap spends
capacity on converting non-convertible users, and the benchmark stays
stuck while the team ships on schedule.

## 5. High Expectation Customer only from Very Disappointed

**The rule.** The High Expectation Customer™ persona (Julie Supan) —
abbreviated HXC throughout the rest of this file — is extracted
exclusively from Q2 and Q3 answers given by Very Disappointed
respondents. Founder imagination, interviews outside the survey,
pre-existing marketing personas, and aggregated "all respondents" data
are not permitted as inputs.

**Why.** Happy users describe themselves when asked who would benefit
most from the product, which makes Very Disappointed Q2 and Q3 a mirror
of the target persona. Any other source dilutes the mirror. Aggregating
across all respondents pulls in users who do not feel the core value.
Founder imagination builds a fantasy persona — a flattering version of
the user the team wishes existed — and the roadmap then optimizes for a
character who is not actually in the user pool.

**What breaks when the rule is skipped.** The persona becomes a
projection rather than a description. Doubling-down investments land in
places the real Fanatics do not care about, the core differentiators
weaken, and the Fanatics start drifting out of the Very Disappointed
bucket without the team understanding why.

## 6. The 50/50 roadmap split is the rule, not a suggestion

**The rule.** The quarterly roadmap allocates roughly half of capacity
to doubling down on fanatics patterns and roughly half to unblocking
hopefuls. The acceptable tolerance is 40/60 to 60/40. Ratios outside
that band fail the check. "Just add a mobile app," "just unblock the
big customers," and "just make the fanatics happier" are not valid
shortcuts around the split.

**Why.** A 100/0 roadmap that only doubles down leaves the benchmark
stuck — the Fanatics are already maxed out on the top box, and the
Hopefuls never convert. A 100/0 roadmap that only unblocks erodes the
differentiation that made the Fanatics fanatic in the first place, and
the top box gets wider but shallower until the Fanatics drift. Both
halves move the number through different mechanisms; neither mechanism
works alone.

**What breaks when the rule is skipped.** The Very Disappointed
percentage stagnates or declines in a way the team cannot explain by
reading roadmap velocity alone. The numbers and the work look
disconnected because the work is pointed at the wrong balance of
audiences.

## What to do when the user tries to violate a rule

These rules are non-negotiables inside the skill's assessment rubric,
which means violation triggers a specific protocol rather than a silent
pass. The protocol, described in more detail in the rules directory, is:

1. **Name the rule.** The skill tells the user which specific rule is
   being violated, in plain language, without making it personal.
2. **Explain the downstream consequence.** The skill walks the user
   through what will break if the rule is skipped — which measurement
   becomes unreliable, which roadmap decision becomes unsound, which
   comparability is lost. The explanation is specific to the rule, not
   generic.
3. **Ask once, then ask again.** The skill asks the user to confirm
   they want to override, and after receiving the first confirmation, it
   re-asks with the downstream consequence restated. Two rounds, not
   one.
4. **Respect the override.** If the user still wants to override after
   both rounds, the skill respects the decision and proceeds. It does
   not continue to argue.
5. **Log the bypass.** The override is recorded in the state file with
   the rule id, a timestamp, and the reason the user gave. The log
   exists so that later reviews of the engine's history can see where
   rules were bent and why.

The protocol is deliberate. The rules are important enough to defend
twice, but the user's autonomy is important enough to respect on the
third request. The log is the accountability mechanism that makes the
compromise visible later.

## Criteria / Rules

- Not Disappointed feedback never enters any planning artifact.
- Engagement filter is applied on every send.
- Respondent identifiers are tracked and filtered across all sends
  forever.
- Blockers come only from sub-split-qualified Somewhat Disappointed.
- HXC persona comes only from Very Disappointed Q2 and Q3.
- Roadmap ratio is inside the 40/60 to 60/40 band.
- Every rule violation is logged in the state file with rule id,
  timestamp, and reason.

## Common pitfalls

- Quietly relaxing one rule because the user pushed back once.
- Conflating two rules into a single "be rigorous" reminder, which
  makes the failure modes invisible.
- Logging overrides as generic "user override" without recording the
  specific rule and the reason — which makes the log useless for later
  review.
- Treating the bypass protocol as adversarial rather than diagnostic.
  The protocol exists to protect the engine, not to block the user.

## When to apply

- Onboarding — so the user meets the rules before they have a chance
  to accidentally violate one.
- Every implementation step — as the substance rubric fires against
  the artifacts the user is producing.
- Every survey send in Operating Mode — for the engagement and
  never-re-survey checks.
- Anytime the user proposes a shortcut around one of the rules.

## Related blocks

- [pmf-sean-ellis-test.md](pmf-sean-ellis-test.md) — the engagement
  and sample-size rules that protect the reading.
- [pmf-segmentation.md](pmf-segmentation.md) — the sub-split and
  politely-disregard rules in their original analytical context.
- [pmf-hxc-framework.md](pmf-hxc-framework.md) — the
  Very-Disappointed-only rule for the persona.
- [pmf-roadmap-fifty-fifty.md](pmf-roadmap-fifty-fifty.md) — the
  50/50 rule in its original strategic context.
- [pmf-iteration-loop.md](pmf-iteration-loop.md) — the
  never-re-survey rule in its original operating context.
