# Onboarding Questions — Canonical Wording

This file defines the canonical wording, explainer text, valid-answer
enums, examples, and parser hints for the universal onboarding
questions of Founder-OS. The flow logic lives in `onboarding.md`.

**All wording in this file is English. The agent translates to the
user's language at runtime** (preserve meaning and tone — never invent
extra options or emojis). Do NOT add decorative emojis to the question
output; the only emoji allowed in the onboarding chat is the agent
identity emoji in the opening greeting.

When a user gives a free-text answer for an enum question, map it to
the nearest enum value and confirm with the user before storing.

---

## Opening — Greeting (one-time, before Question 1)

Send this verbatim (translate to the user's language). Substitute
`{user_first_name}` from the user profile; substitute the agent emoji
from IDENTITY.md.

> Hey {user_first_name} — welcome. {agent_emoji}
>
> I'll help you build your company with more clarity, focus, and execution.
>
> First, I'll ask a few questions about your business, stage, goals, and biggest bottleneck.
>
> Then I'll create your first roadmap using proven playbooks and expert knowledge, so you know what matters most and what to do next.
>
> From there, I'll stay by your side to help you execute and keep moving.
>
> Let's go.

Then move directly into Question 1.

---

## Question 1 — What are you building?

**Wording:** "What are you building?"

**Explainer:** "Pick the business model that fits best. This shapes
which playbooks and KPIs I surface for you later."

**Type:** enum
**Valid answers:** `Software` | `Service` | `E-Com` | `Content`

**Options to present (no emojis):**
- **Software / AI** — SaaS, app, platform, tool
- **Service Business** — agency, consulting, coaching, done-for-you
- **E-Commerce** — shop, brand, DTC, physical product
- **Content / Media** — newsletter, course, community, membership

**Store:** `business_profile.build_type`

**Parser hints:**
- "SaaS", "App", "platform", "tool" → `Software`
- "agency", "consulting", "coaching", "done-for-you" → `Service`
- "shop", "brand", "DTC", "product" → `E-Com`
- "newsletter", "course", "community", "membership" → `Content`

---

## Question 2 — Who do you sell to?

**Wording:** "Who do you sell to?"

**Explainer:** "Your market changes how I approach positioning,
acquisition, and sales with you."

**Type:** enum
**Valid answers:** `B2B` | `B2C`

**Options to present:**
- **B2B** — companies, businesses, organizations
- **B2C** — individuals, end consumers

**Store:** `business_profile.buyer`

**Parser hints:**
- "companies", "businesses" → `B2B`
- "individuals", "consumers" → `B2C`
- "both" → ask follow-up: "Which one dominates today (>70% of revenue)?"

---

## Question 3 — Where do you stand?

**Wording:** "Where do you stand right now?"

**Explainer:** "Pick the phase that best describes your business
today. This drives which path I take you on (PMF / GTM / Scale)."

**Type:** enum
**Valid answers:** `Product-Market Fit` | `GTM` | `Scale`

**Options to present:**
- **Product-Market Fit** — You're building, testing, or validating an
  early version. No paying customers yet, or only very few. You're
  still figuring out whether anyone would actually miss your product
  if it disappeared.
- **Go-to-Market (GTM)** — You're actively trying to win customers
  and build a repeatable acquisition motion. You have first paying
  customers but no proven channel yet.
- **Scale** — You already have traction and a working acquisition
  motion. You want to grow faster, more predictably, and more
  profitably.

**Store:** `business_profile.stage`

**Parser hints:**
- "pre-revenue", "no paying customers", "<5 customers", "MVP" → `Product-Market Fit`
- "first customers, looking for repeatable acquisition" → `GTM`
- "repeatable acquisition working, optimizing growth" → `Scale`

This answer drives **path routing** (see `onboarding.md` § Path Routing).

---

## Question 3a — Where exactly on the PMF path? (only if Question 3 = Product-Market Fit)

**Wording:** "Where exactly on the PMF path?"

**Context to send before the options (verbatim):**

> Product-Market Fit (PMF) means: your users would miss your product
> if it disappeared. There's a simple test for it — you ask your
> active users "How disappointed would you be if you couldn't use
> this product anymore?" If 40% or more answer "very disappointed,"
> you have PMF.
>
> Where are you on the path to that?

**Type:** enum
**Valid answers:** `idea_only` | `mvp_built` | `engaged_users` | `survey_running`

**Options to present (each option self-contained — no jargon required):**
- **Just an idea, no product yet** — you haven't built anything yet,
  you're talking to potential users to understand the problem.
  → Start: Step 1.1
- **First version (MVP) is live, but barely any usage** — you have a
  first working version (an MVP = Minimum Viable Product, the
  smallest sensible version) but no or very few active users yet.
  → Start: Step 1.3
- **10+ active users, but not measured yet** — people are using your
  product regularly, but you haven't run the 40% test.
  → Start: Step 1.4
- **Test is running, score still under 40%** — you're surveying users
  regularly and working to get above the threshold.
  → Start: Step 1.5

**Store:** `business_profile.pmf_substage`

**Routing logic:**
- `idea_only` → set `roadmap.currentSubphase = "1.1"` and `here:true` on subs[0]
- `mvp_built` → set `roadmap.currentSubphase = "1.3"` and `here:true` on subs[2]
- `engaged_users` → set `roadmap.currentSubphase = "1.4"` and `here:true` on subs[3]
- `survey_running` → set `roadmap.currentSubphase = "1.5"` and `here:true` on subs[4]

In all cases: ensure exactly ONE sub has `here:true` (invariant per SKILL.md).

**Mandatory:** if the user replies with "I don't know" / "doesn't
matter," re-ask once with a brief clarification of the four options.
If they still won't pick, default to `idea_only` and tell them they
can change it later.

---

## Question 3b — Where exactly on the GTM path? (only if Question 3 = GTM)

**Wording:** "Where exactly are you in your B2B sales motion right now?"

**Context to send before the options (verbatim):**

> Pick the description that fits best.

**Type:** enum
**Valid answers:** `repeatable_motion` | `non_founder_sales` | `scalable` | `customer_success` | `profitable`

**Options to present (each option self-contained — no step names, no jargon):**
- **A)** I have closed a few paying customers, but every deal looked
  different. I cannot write down in one document how I sell.
  → Start: Step 2.1
- **B)** I have a clear playbook and can close reliably myself. But it
  is not yet proven that an employed sales rep can sell successfully
  using it.
  → Start: Step 2.2
- **C)** At least one employed sales rep is selling successfully and
  producing significantly more than their salary costs. Now it is
  about adding more reps with the same productivity — and building a
  reliable marketing channel that delivers enough leads.
  → Start: Step 2.3
- **D)** Sales is fundamentally scaling — but customers are churning
  more often or becoming less successful since we added more reps.
  → Start: Step 2.4
- **E)** Growth is running and churn is under control. But we are still
  losing money per customer or it takes too long for acquisition costs
  to pay back.
  → Start: Step 2.5

**Store:** `business_profile.gtm_substage`

**Routing logic:**
- `repeatable_motion` → set `roadmap.currentSubphase = "2.1"` and `here:true` on subs[0] (default seed)
- `non_founder_sales` → set `roadmap.currentSubphase = "2.2"` and `here:true` on subs[1]
- `scalable` → set `roadmap.currentSubphase = "2.3"` and `here:true` on subs[2]
- `customer_success` → set `roadmap.currentSubphase = "2.4"` and `here:true` on subs[3]
- `profitable` → set `roadmap.currentSubphase = "2.5"` and `here:true` on subs[4]

In all cases: ensure exactly ONE sub has `here:true` (invariant per SKILL.md).

**Mandatory:** if the user replies with "I don't know" / "doesn't
matter," re-ask once with a brief clarification of the five options.
If they still won't pick, default to `repeatable_motion` and tell them
they can change it later.

---

## Question 4 — What industry do your customers work in?

**Wording:** "What industry do your customers work in?"

**Explainer:** "Industry context helps me tailor benchmarks,
anti-patterns, and example playbooks for you."

**Type:** enum_with_other
**Valid answers:** `Software / Tech` | `Real Estate` | `Healthcare` | `Finance` | `E-Commerce / Retail` | `Trades / Building / Field Services` | `Education` | `Other`

**Options to present:**
- **Software / Tech**
- **Real Estate**
- **Healthcare**
- **Finance**
- **E-Commerce / Retail**
- **Trades / Building / Field Services**
- **Education**
- **Other** — please specify (free text)

**Store:** `business_profile.industry`
**Parser hints:** if `Other`, capture the verbatim free-text label too.

---

## Question 5 — What exactly are you building, and for whom?

**Wording:** "Tell me in a few sentences: What is your product or
service? What concrete problem does it solve? And who is the customer
that buys it?"

**Explainer:** "Example: 'I'm building an AI tool that automatically
writes call notes for sales reps. The problem: reps spend 1-2 hours a
day on notes instead of selling. Customers are B2B SaaS companies
with 10-50 sales reps.'
Write as much as you want — the more detail, the better I can advise
you later."

**Type:** free_text (structured into three sub-fields)

**Store:**
- `business_profile.product_description` — what the product/service is
- `business_profile.problem_solved` — the concrete problem it solves
- `business_profile.customer_description` — who the customer is
- `business_profile.elevator_pitch` — the verbatim full answer (kept
  for later reuse: ICP hypothesis, messaging, bottleneck matching)

**Parser hints:** parse the answer into three parts. If any of the
three is missing or unclear, ask one targeted follow-up before
storing. Always store the verbatim full answer in `elevator_pitch`
regardless.

---

## Question 6 — Tell me how it's going right now.

**Wording:** "Tell me where you are right now and how it's going."

**Explainer:** "Concretely, what helps me:
- **Numbers today:** revenue (€0, <10k MRR, 50k+ MRR…), team size,
  customer count
- **What's happening:** what projects are running? What's working?
  What isn't?
- **How it feels:** are you in flow or on the hamster wheel? What
  drains you? What gives you energy?

Feel free to write a detailed answer — the more context I have now,
the better I can help you later."

**Type:** free_text (structured)

**Store:** `focus.today`

**Parser hints:** try to extract:
- revenue range (€0, <€10k MRR, €10-50k MRR, €50k+ MRR) → also store
  in `focus.revenue_today` if extractable
- team size (1, 2-5, 6-15, 15+) → also store in `focus.team_size_today`
- one-line status → also store in `focus.status_one_liner`

Always keep the verbatim full answer in `focus.today`.

---

## Question 7 — Where do you want to go?

**Wording:** "Where do you want to be in 12 months? And what's your
90-day milestone?"

**Explainer:** "Two parts. Tell me whatever fits — numbers, qualitative
goals, or both.

- **12-month vision** — examples: revenue target ('€500k ARR'),
  customer count ('~50 paying'), team size ('8-person team'),
  qualitative goals ('category leader in DACH', 'expanded to
  enterprise segment'). Mix what fits.
- **90-day milestone** — concrete checkpoint we measure against in 3
  months. Examples: revenue + customer count ('first €10k MRR with 5
  paying customers'), or qualitative ('first sales rep hired',
  'playbook v1 locked'). Concrete, not a vision."

**Type:** two-part structured

**Store:** `focus.goal_12m` and `focus.milestone_90d` are STRUCTURED
OBJECTS, not free strings. Schema for each:

```json
{
  "revenue_target": null,           // string, e.g. "€500k ARR" or "<10k MRR"
  "customer_count_target": null,    // number or string range
  "team_size_target": null,         // number
  "qualitative_goals": [],          // array of strings (anything that isn't a number)
  "raw_text": null                  // verbatim user input — always populated
}
```

**Parser hints:**
- **`raw_text` is ALWAYS populated** with the user's verbatim words for
  that part — audit trail, never empty if any answer was given.
- Extract `revenue_target` if a revenue figure or range is mentioned
  (€, $, MRR, ARR, "revenue").
- Extract `customer_count_target` if a customer or user count is
  mentioned ("50 customers", "100 paying users").
- Extract `team_size_target` if a team size is mentioned ("8-person
  team", "5 hires").
- Everything else (positioning goals, "category leader", "first sales
  rep hired", "playbook v1 locked", etc.) → append to
  `qualitative_goals` as separate array entries.
- If user gives ONLY 12-month OR ONLY 90-day, ask explicitly for the
  other.
- If a part is purely qualitative (no numbers at all) → that's fine,
  numeric fields stay null, qualitative_goals + raw_text carry the
  substance. Don't pressure the user for numbers if they didn't offer
  them.

---

## Question 8 — What's holding you back?

**Wording:** "What's slowing you down most right now? What's the
biggest brake to the next level?"

**Explainer:** "Pick the ONE biggest brake. Common patterns to help
you choose:"

**Examples / typical brakes:**
- Product not delivering enough value yet
- Unclear offer
- Unclear target customer (ICP)
- Not enough leads
- Low conversion
- No repeatable channel
- Lack of focus / too many priorities
- Delivery or capacity issues
- Team / operational chaos

**Type:** free_text

**Store:**
- `focus.bottleneck`
- `bottleneck.title` (top-level dashboard field, mirrored)

**Parser hints:** must be ONE bottleneck. If user lists multiple, ask:
"Which one is the biggest right now?"
