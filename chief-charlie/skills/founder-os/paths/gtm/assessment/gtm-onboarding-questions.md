# GTM Path — Onboarding Questions Q9-Q12

Run only after path routing has committed `current_path: "gtm"`. These
4 questions deepen the picture beyond the universal Q1-Q8 and feed the
ICP playbook, messaging playbook, and GTM plan.

Ask one at a time. After each answer, acknowledge briefly and move on.
Skip a question if an existing workspace artifact already answers it
(summarize what you found and ask if it's still accurate).

---

## Q9 — Who is your ideal customer?

**Wording:** "Who is your ideal customer?"

**Pre-fill from Q5:** if `business_profile.customer_description` is
already set, start the question by quoting it back: "You told me
earlier your customers are: '{customer_description}'. Let's go
deeper." Then proceed with the explainer below. Do NOT re-ask Q5
content from scratch.

**Explainer:** "Go beyond industry and size. What situation is the
person in? What pain do they feel? What triggers them to search for a
solution? Be as specific as you can — name the role, the moment, and
the trigger."

**Examples to prompt richer answers:**
- "Solo agency owner doing 10-15k MRR who just hired their first VA
  and realized their delivery process is undocumented chaos."
- "Head of Sales at 50-200 person SaaS who got a CMO mandate to
  rebuild outbound after the SDR team stopped hitting quota."

**Type:** free_text (structured if possible)

**Store:** `path_state.icp.hypothesis_v1`

**Parser hints:** try to extract `role`, `situation`, `pain`,
`trigger` as separate sub-fields. If the user gives only "B2B SaaS
companies", push back: "Zu generisch — welcher Mensch in welcher
Situation? Wer wacht morgens auf und googelt nach einer Lösung?"

---

## Q10 — What have you tried so far to win customers?

**Wording:** "What have you tried so far to win customers — and what
worked or didn't?"

**Explainer:** "Charlie uses your history to skip failures and build
on signals. Tell me the channels you tried, what happened, and where
you saw early traction (even small)."

**Examples of what to capture:**
- Channels tested (cold email, LinkedIn, paid ads, referrals,
  content, events, partnerships)
- Outcome per channel ("got 3 calls but no closes", "20% reply rate
  but bad-fit leads", "1 customer from a podcast appearance")
- Current best-performing channel, even if weak

**Type:** free_text

**Store:** `path_state.acquisition_history`

**Parser hints:** try to capture `channels_tried`, `signals_seen`,
`current_best_channel`. If the user says "nothing yet", that's a
valid answer — note it and proceed.

---

## Q11 — What does your sales process look like today?

**Wording:** "What does your sales process look like today?"

**Explainer:** "Pick the option closest to your current state. We
need to know whether we're documenting an existing motion or
designing one from scratch."

**Type:** enum

**Valid answers:** `none` | `opportunistic` | `loose` | `defined` | `repeatable`

**Options to present:**
- **No sales process yet** — you haven't tried to sell yet, or you've
  done a few opportunistic conversations with no structure.
- **Opportunistic / ad hoc** — every deal looks different; whatever
  works in the moment.
- **Loose structure but not repeatable** — you have a rough idea of
  the steps but they vary call-to-call.
- **Defined flow (Discovery → Demo → Close)** — clear stages, but
  you're still the only one who can run it.
- **Repeatable and delegatable** — documented, others could run it
  with reasonable training.

**Store:** `path_state.sales_process.maturity`

**Parser hints:**
- "noch nichts", "kein Prozess" → `none`
- "ad hoc", "spontan", "anders bei jedem Kunden" → `opportunistic`
- "grob, aber inkonsistent" → `loose`
- "Discovery → Demo → Close" → `defined`
- "dokumentiert, andere könnten das machen" → `repeatable`

---

## Q12 — What's your role and what are you responsible for?

**Wording:** "What's your role in the business — and what are you
responsible for?"

**Explainer:** "Tell me where your time goes today. Are you doing
sales calls yourself? Building product? Running the team? This shapes
which parts of the GTM motion you can realistically own vs. which we
need to delegate or systemize."

**Examples of what to capture:**
- Time split (sales / product / ops / management) in rough %
- Whether you're the only seller, the main seller, or stepping back
- What you wish you could stop doing
- What only you can do

**Type:** free_text

**Store:**
- `path_state.founder_role.description`
- `path_state.founder_role.is_primary_seller` (bool — derive from
  answer; ask follow-up if unclear)

**Parser hints:** if the user is the primary seller → flag in
`path_state` so the GTM plan starts from the founder-led playbook
(Step 4 — Find a repeatable founder-led motion). If not → start from
Step 5 (Prove non-founders can sell).
