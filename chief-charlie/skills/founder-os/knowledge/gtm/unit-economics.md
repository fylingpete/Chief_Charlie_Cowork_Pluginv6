---
source: matrix_partners_zero_to_100
source_type: synthesis
source_id: founder-os-gtm-step-2.5
source_title: "Make it profitable (Skok Phase 8)"
domain: go-to-market
sub_topic: unit-economics
stage: [go-to-market, scaling]
problem: [growing-but-unprofitable, unhealthy-ltv-cac, long-cac-payback, unsure-if-ready-to-scale, channel-mix-broken]
action_type: framework
key_insight: "The three gates are non-negotiable: LTV:CAC > 3, CAC payback < 12-18 months, gross margin > 70%. Failing any one of them means scaling will burn cash without producing profit. These metrics matter ONLY at this stage — obsessing over CAC at $100K ARR is a distraction. At $5M+ ARR, they're the gate to Phase 3."
language: en
date_added: 2026-05-05
---

# Make it profitable

Phase 2.5 is the **last gate before Phase 3 (Hit the gas).** Skok is
explicit: hitting the gas without proving unit economics is the most
expensive mistake in the entire roadmap. You can recover from a bad
sales motion. You can recover from churn problems. You cannot easily
recover from scaling a structurally unprofitable business — by the time
the math catches up, you've burned the runway.

The job of 2.5 is simple to state and hard to do: **prove that for
every customer you acquire, the math works.** Three numbers, three
gates.

## The three gates

### Gate 1: LTV:CAC > 3

**LTV (Lifetime Value)** = average revenue per account × gross margin
× average customer lifetime in months.

**CAC (Customer Acquisition Cost)** = total sales + marketing spend
÷ new customers acquired in the period.

**The ratio:**
- < 1 — you're losing money on every customer (catastrophic)
- 1 to 3 — you're not making enough to fund growth (sub-scale)
- 3 to 5 — healthy, scaling profitably
- > 5 — possibly under-investing in growth (could spend more)

**Why 3 is the floor:** at LTV:CAC = 3, after accounting for opex
overhead and unmodeled costs, you have just enough margin to fund
re-investment in growth. Below 3, you can't fund the growth you need
to stay competitive.

### Gate 2: CAC Payback < 12-18 months

CAC Payback = months until cumulative gross margin from a customer
covers their CAC.

- < 6 months: excellent
- 6-12 months: healthy SMB SaaS
- 12-18 months: healthy enterprise SaaS
- > 18 months: cash trough is deep — survivable only if VC-funded
  or massive expansion revenue

**Why payback matters even with strong LTV:CAC.** A business with
LTV:CAC = 5 but payback = 36 months is a cash-trough business. You
need a lot of capital to bridge the trough until customers turn
profitable. If LTV:CAC is also weak, the trough is fatal.

### Gate 3: Gross Margin > 70%

Gross margin = (revenue - cost of revenue) / revenue.

For SaaS, cost of revenue includes: hosting, support staffing,
third-party APIs, payment processing, customer-facing tooling.

- < 50%: you're not really SaaS — you're a services or hardware
  business with software dressing
- 50-70%: under-margined SaaS, scaling will be hard
- 70-80%: typical healthy SaaS
- 80%+: best-in-class

If gross margin is low, both LTV and payback math get hurt. Fixing
margin usually means fixing infrastructure costs, support load
(self-serve vs human-touch), or pricing.

## Channel-level economics — the hidden trap

Aggregate CAC hides the truth. If channel A has CAC = $500 and
channel B has CAC = $5000, scaling B at the cost of A wrecks
unit economics even if blended CAC stays "ok."

**Compute CAC per channel monthly:**

```
Channel CAC = (channel marketing spend + attributed sales effort)
             ÷ customers acquired through that channel
```

Add LTV per channel (channels often have different ICP fit and
different retention). The answer is **profitable channels by
LTV:CAC, not by CAC alone.**

A channel with $5K CAC and $30K LTV is better than a channel with
$500 CAC and $1K LTV. The former is a profit machine; the latter
is a treadmill.

## Hormozi's complementary frameworks

- **LTGP vs CAC** — Lifetime Gross Profit (LTV × gross margin)
  is what actually pays back CAC. Many founders compute LTV on
  revenue and miss this.
- **Premium pricing** — the cheapest way to fix unit economics is
  often to charge more. Most B2B founders under-price.
- **Ad-spend phases** — don't run paid before you can convert
  organic. Paid amplifies a broken funnel into broken-at-scale.
- **Client-financed acquisition** — design pricing so the first
  payment covers CAC. Eliminates the cash trough entirely.

## The SaaS cash trough — Skok's framework

Even with good unit economics, **the SaaS cash flow trough deepens
as growth accelerates.** This is a feature, not a bug — you're
investing customers' future revenue today to acquire them faster.

The trough math:
- Month 1: pay full CAC, collect month-1 revenue
- Month X: cumulative revenue catches up to CAC (= payback)
- Month X+: every additional month is pure margin

If you're growing fast, more new customers means more month-1
losses, even if every cohort is healthy. Investors who don't
understand this panic at the wrong moment.

**Unit economics is the tool that proves a money-losing SaaS
company is healthy versus dying.** Show the cohort math, prove the
LTV:CAC, and the losses become an investment story instead of a
problem.

## The Rule of 40 — fundraise readiness

Skok's framing: **Growth Rate + Profitability ≥ 40%**.

- Growing 60% with -20% margin: 40 = pass
- Growing 30% with 10% margin: 40 = pass
- Growing 20% with 0% margin: 20 = fail

The Rule of 40 is what investors use to judge SaaS valuation. EV /
Gross Profit is a stronger valuation predictor than EV / Revenue, and
the Rule of 40 is what determines the multiple.

If you're at 40+, you're fundable. Below, you're a recovery story.

## Stage-appropriate metrics — Skok's rule

**Don't obsess over CAC at $100K ARR.** Each stage has its right
metrics:

- **PMF (Phase 1):** Sean Ellis 40%, engagement, retention cohorts
- **Repeatable motion (2.1-2.3):** Bookings components — leads,
  conversion, PPR
- **Profitable (2.5+):** Full unit economics — LTV:CAC, payback,
  gross margin, Rule of 40

A founder spending hours on CAC dashboards before they have a
repeatable motion is misallocating attention.

## Bookings vs ARR — leading indicator rule

Same as 2.3: track **bookings (Net New ARR = New + Expansion -
Churned) monthly**, not ARR. ARR lags by 6-12 months. If bookings
flatlines while ARR rises, you're in trouble before you see it.

In 2.5 add **bookings broken down by channel** — to spot a channel
that's contributing to ARR but not to bookings (i.e. churn is
eating its contribution).

## Exit criteria

Phase 2.5 is done when:

1. LTV:CAC > 3 measured on cohorts old enough to validate (≥12 months)
2. CAC payback < 18 months (< 12 if SMB)
3. Gross margin > 70%
4. Channel-level economics computed monthly; no scaling-blocking
   channel in the mix
5. Rule of 40 ≥ 40 (or clear path to it within 2 quarters)
6. Cash-trough modeled — runway covers the trough at planned
   scale OR financing is in place

When all six are true, you have proven you can scale profitably.
**Phase 3 (Hit the gas) starts now.**

## Anti-patterns

- **Aggregate CAC only, no channel breakdown.** Hides the unit
  economics killer.
- **LTV computed on revenue, not gross profit.** Inflates LTV:CAC
  by ~30%. Use LTGP.
- **Scaling before payback < 18 months.** Cash trough deepens
  faster than you can fundraise.
- **Fixing margin by cutting support quality.** Saves cost,
  destroys retention, kills LTV. Net negative.
- **Rule of 40 fail being papered over with growth.** A 100%-growth,
  -80% margin company is still failing the rule and will be
  unfundable when growth slows.
- **Treating 2.5 as one-time check.** Unit economics is monthly.
  Channel mix shifts; pricing changes; retention drifts. Re-measure
  every month.

## Connection to other steps

- **From 2.4:** LTV depends on retention. Negative churn from 2.4
  is what makes the best LTV:CAC ratios possible.
- **From 2.3:** Channel mix from 2.3 is the input to channel-level
  economics here.
- **From 2.1:** The price point and ICP set in 2.1 are what 2.5
  is now testing against the gates. If 2.5 fails, the loop usually
  goes back to 2.1 (re-segment) or pricing (raise prices).
- **To Phase 3 (Scaling):** This step is the gate. Don't open it
  until all six exit criteria are met.

## Default sources for this step

- Skok — Phase 8 unit economics
- Hormozi — LTGP vs CAC
- YC — B2B pricing
- Skok — Rule of 40
