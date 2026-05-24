# Template Section Update

Triggered when the user wants to update a specific section of one of
the structured GTM templates without doing a full hypothesis swap.

This is for **incremental refinement** — small edits, new evidence,
threshold flips. For a **fundamental hypothesis change**, use
`icp-adjustment.md` or `messaging-adjustment.md` instead.

## When to run this

- A `call-debrief.md` produced a new objection — add it to
  `objection-map.md`
- A discovery call surfaced new buyer-language — extend
  `messaging-doc.md` Buyer-Word Trail
- A repeat-win was closed — increment Repeat-Win Validation in
  `icp-doc.md` and/or `messaging-doc.md`
- A channel test ended with a result — record in `channel-test.md`
  and possibly flip status
- Conversion-rate data accumulated — refresh stage-by-stage table in
  `sales-playbook.md`
- Activation data accumulated — refresh Cohort Performance table in
  `onboarding-flow.md`

## Step 1: Pick template + section

```
Welches Template + welche Sektion willst du aktualisieren?

Step 2.1:
  1. icp-doc.md — Positive / Negative / Evidence Trail / Repeat-Win
  2. messaging-doc.md — Core Message / Quarter-Inch / Buyer-Word Trail / Channel Variants
  3. channel-test.md — Daily/Weekly Log / Cost Tracking / Result
  4. sales-playbook.md — Stage-by-Stage / Discovery Script / Pricing / Repeatability Evidence

Step 2.2:
  5. sales-playbook.md (v1.5) — Objection-Handling / Hand-off / Stranger-Test
  6. objection-map.md — Objection 1-10 / Lost-Deal Source Trail / Coaching

Step 2.3:
  7. bookings-plan.md — Headline / Rep Capacity / Lead-Source Mix / Pipeline Coverage
  8. marketing-sales-contract.md — Cohort Rates / Volume / Escalation

Step 2.4:
  9. activation-metric-doc.md — Predictive Validation / Cohort
  10. onboarding-flow.md — Friction Audit / Cohort Performance / Iteration Log

Step 2.5:
  11. unit-economics-model.md — Three Gates / Channel-Level / Cash-Trough / Rule of 40
```

## Step 2: Show current state

Read the chosen template, locate the section, and show the user the
current state. Also load relevant entries from
`decisions_learnings.jsonl` (grep by template name or category).

```
## Aktueller Stand: {template} → {section}

{Inhalt der Sektion}

### Relevante Learnings seit letztem Update
- {Learning 1} ({Datum}) — {category}
- {Learning 2} ({Datum}) — {category}

### Mein Vorschlag
{Konkrete Aenderungen basierend auf den Learnings}
```

## Step 3: Revise

After user confirmation:

1. Update the chosen section in the template file
2. Update the `last_updated` field in frontmatter
3. If a Contamination-Check item flipped (e.g. "5–10 repeat wins" was
   `no`, now `yes`) — update it explicitly
4. If all Contamination-Check items pass for a `v1-draft` template, ask
   the user whether to flip to `v1-locked`. Do NOT auto-flip — locking
   is a deliberate decision.

## Step 4: Cascade check

Some sections cascade. If updated, ask whether to update related docs:

| Updated | Cascades to |
|---|---|
| `icp-doc.md` Negative section | `objection-map.md`, `marketing-sales-contract.md` MQL Definition |
| `messaging-doc.md` Core Message | `sales-playbook.md` opener, `channel-test.md` message_used |
| `channel-test.md` Result = winner | `bookings-plan.md` Lead-Source Mix |
| `objection-map.md` new entry | `sales-playbook.md` Objection-Handling section |
| `activation-metric-doc.md` validated | `onboarding-flow.md` Activation prerequisites |
| `unit-economics-model.md` channel CAC | `marketing-sales-contract.md` Lead-Source Mix |

For deep cascades — full hypothesis change — use `icp-adjustment.md`
or `messaging-adjustment.md` instead.

## Status flips (Contamination-Check passes)

- `v1-draft` → `v1-locked` ONLY when all Contamination-Check items
  pass AND the user explicitly confirms.
- `v1-locked` → `v2-draft` only via `icp-adjustment.md` or
  `messaging-adjustment.md`.
- `v2-draft` → `v2-locked` ONLY after re-validation against new
  evidence (Repeat-Win, Buyer-Word Trail, Cohort-Validation —
  template-dependent).

## Rules

- **One section at a time** — don't batch updates across multiple
  templates in one operation.
- **Always confirm before writing** — show diff, get nod.
- **Locked → Draft is one-way via adjustment-files**, not via this
  operation. This operation is incremental, not transformative.
- **Append, don't overwrite, log entries** — Buyer-Word Trail,
  Lost-Deal Source Trail, Iteration Log are append-only.

## Related files

- `icp-adjustment.md` — full ICP hypothesis change
- `messaging-adjustment.md` — full messaging hypothesis change
- `learning-documentation.md` — for capturing the learning that
  triggers an update; can route here afterward
- `decisions_learnings.jsonl` — append a `template_section_updated`
  entry on each run for the audit trail
