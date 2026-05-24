---
source: david_skok
source_type: video
source_id: "301504369"
source_url: https://vimeo.com/301504369
source_title: "The SaaS Business Model & Metrics - Part 1"
domain: saas-metrics
sub_topic: cohort-analysis
phase: 6
related_domains: []
stage: [go-to-market, scaling]
problem: [funnel-conversion-unclear, channel-mix-unclear, sales-marketing-misalignment]
action_type: tactic
key_insight: "Funnel conversion rates require cohort analysis (not snapshots) — track each January cohort across months to see real conversion; reverse-engineer leads needed by working backwards from desired closes to define the marketing-sales contract"
language: en
speakers: [david_skok]
date_added: 2026-05-05
---

## Cohort-Based Funnel Conversion + Sales-Marketing Contract — Phase 6, Matrix Partners (David Skok)

The naïve way to compute funnel conversion ("trials this month divided by visitors this month") produces meaningless numbers because trials don't close in the same period as the visit. The right way is **cohort analysis**: take all visitors who arrived in January, track that group across months, and watch what fraction convert to trials, then to closes, over the 3-5 months it actually takes.

### What to Track as Time Series

Every funnel metric should be a time-series graph, not a snapshot. You cannot tell whether a number is improving from a single point.

- Visitors per month
- Sign-ups / trials per month
- Closed deals per month
- **Conversion rate at each step** — computed from cohorts, not snapshots

**Lord Kelvin's principle applies:** if you want to improve something, you have to measure it. Display these metrics where the team sees them daily — organizations spontaneously fix what they can see.

### Source-by-Source Conversion

Different lead sources convert at different rates with different deal sizes. A Facebook lead might convert at 1% but produce $8K customers; a paid-search lead might convert at 5% but produce $2K customers. Without segmenting by source, you can't tell which channel is profitable.

This is also how you justify expensive channels: a pricey channel with high ROI beats a cheap channel with low ROI.

### Reverse-Engineering the Marketing-Sales Contract

Once funnel conversion rates are known, work backwards from bookings goals:

```
Want: 4 closed deals per rep per quarter
At 20% close rate from opportunity:        20 opportunities needed
At 5 MQLs per opportunity:                 100 MQLs needed
At 1 MQL per 5 raw leads:                  500 raw leads needed
× 10 reps:                                 5,000 raw leads / quarter
```

This calculation produces the **single best fix for the sales-vs-marketing blame game**. Sales blames marketing for not producing enough leads. Marketing blames sales for not following up. Both are right, but neither has a number.

The reverse-engineered formula creates a **contract** — marketing commits to N MQLs per period, sales commits to working them, and both teams plan together. Hiring sales reps faster requires hiring marketing-supply faster, in lockstep.

### Productivity vs Plan

Plot two lines: assigned quota (sum of reps × quota) and actual bookings. The gap is typically ~85% achievement. Use the 0.85 multiplier to over-assign quota: if you need $1M, assign $1M / 0.85 = $1.18M.

## Key Takeaway
Cohort analysis reveals the real funnel; reverse-engineering from closes to leads creates the marketing-sales contract that fixes the blame game.

## When to Apply
- Building a funnel-conversion dashboard for the first time
- Sales blames marketing for lead quality (or vice versa)
- Planning the marketing budget against the sales hiring plan
